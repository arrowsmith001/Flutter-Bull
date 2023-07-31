

// Index
//import * as firebase from 'index'; //'firebase';
import * as functionsv1 from "firebase-functions";
import * as http from 'firebase-functions/v2/https';


// Firebase
//import * as game from 'index'; // 'game';
import * as firestore from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import * as auth from "firebase-admin/auth";
import * as logger from "firebase-functions/logger";
import * as promises from 'node:timers/promises';



const delaysOn = false;

const app = admin.initializeApp();
const db = firestore.initializeFirestore(app);




// TODO: Separate into files!!



export const onUserCreated = functionsv1.auth.user().onCreate(handleCreatedUser);


export const createGameRoom = http.onCall(
    async (req: http.CallableRequest) => {

        var userId = req.data as string;

        await createGameRoomImpl(userId);
    });


export const joinGameRoom = http.onCall(
    async (req: http.CallableRequest) => {


        var userId = req.data['userId'] as string;
        var roomCode = req.data['roomCode'] as string;

        await joinGameRoomImpl(userId, roomCode);

    });

export const removeFromRoom = http.onCall(
    async (req: http.CallableRequest) => {

        var userId = req.data['userId'] as string;
        var roomId = req.data['roomId'] as string;

        removeFromRoomImpl(userId, roomId);
    });


export const startGame = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data as string;

        startGameImpl(roomId);
    });

export const returnToLobby = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data as string;

        returnToLobbyImpl(roomId);
    });


export const submitText = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var userId = req.data['userId'] as string;
        var text = req.data['text'] as string;

        submitTextImpl(roomId, userId, text);
    });


// Blocking
/* exports.onUserCreated = functionsv2.identity.beforeUserCreated(async event => {
    await createPlayerProfile('event.data.uid');
}); */






// For testing only
export const invokeOnUserCreate = http.onCall(
    async (req: http.CallableRequest) => {

        var id = req.data;

        onUserCreateInvoked(id);
    });








async function onUserCreateInvoked(id: string) {
    var user = await auth.getAuth().getUser(id);
    await handleCreatedUser(user);
}


async function createGameRoomImpl(userId: string) {

    await _setPlayerStatus(userId, 'Creating Game Session');
    if (delaysOn) promises.setTimeout(1000);

    await db.runTransaction(async (txn) => {

        var newCode = await _tryGenerateNewRoomCode(5);

        var newRoomDoc = db.collection('rooms').doc();
        var playerDoc = db.collection('players').doc(userId);

        var newRoom = { 'id': newRoomDoc.id, 'roomCode': newCode, 'playerIds': [userId], 'phase': 0 };
        var playerUpdates = { 'occupiedRoomId': newRoomDoc.id };

        await txn
            .create(newRoomDoc, newRoom)
            .update(playerDoc, playerUpdates);


    });

    await _setPlayerStatus(userId, null);

}

async function joinGameRoomImpl(userId: string, roomCode: string) {

    await _setPlayerStatus(userId, 'Joining Game Session');
    if (delaysOn) promises.setTimeout(1000);

    await db.runTransaction(async (txn) => {

        var roomsWhereCode = db.collection('rooms').where('roomCode', '==', roomCode);

        var roomCountQuery = roomsWhereCode.count();
        var roomCount = await txn.get(roomCountQuery);
        var count = roomCount.data().count;

        if (count != 1) throw Error('Not a single room');

        var roomDoc = await txn.get(roomsWhereCode);
        var room = roomDoc.docs[0];

        var roomRef = room.ref;
        var roomData = room.data();

        var playerIds = roomData['playerIds'] as string[];
        var newPlayerIds = playerIds.concat([userId]);

        var roomUpdates = { 'playerIds': newPlayerIds };
        var playerUpdates = { 'occupiedRoomId': roomRef.id };


        var playerDoc = db.collection('players').doc(userId);

        await txn
            .update(roomRef, roomUpdates)
            .update(playerDoc, playerUpdates);


    });

    await _setPlayerStatus(userId, null);

}

async function removeFromRoomImpl(userId: string, roomId: string) {

    await db.runTransaction(async (txn) => {

        var playerDoc = db.collection('players').doc(userId);
        var roomDoc = db.collection('rooms').doc(roomId);

        var getResult = await txn.get(roomDoc);
        var roomData = getResult.data()!;

        var playerIds: string[] = roomData['playerIds'];
        var newPlayerIds = playerIds.filter((s) => s != userId);

        var roomUpdatePromise = txn.update(roomDoc, { 'playerIds': newPlayerIds });
        var playerUpdatePromise = txn.update(playerDoc, { 'occupiedRoomId': null });


        await Promise.all([roomUpdatePromise, playerUpdatePromise]);
    });

}

enum GameRoomPhase {
    lobby, writing, selecting, reading, reveals, results
}

// TODO: Ensure player cannot join while starting game
async function startGameImpl(roomId: string) {
    await db.runTransaction(async (txn) => {

        var roomRef = db.collection('rooms').doc(roomId);

        var roomQuery = await txn.get(roomRef);
        var room = roomQuery.data();

        var playerIds = room!['playerIds'];
        var targets = _getTruthOrLieTargetMap(playerIds);


        await txn
            .update(roomRef, { 'targets': Object.fromEntries(targets) })
            .update(roomRef, { 'texts': {} })
            .update(roomRef, { 'phase': GameRoomPhase.writing });
    });
}


async function returnToLobbyImpl(roomId: string) {
    await db.runTransaction(async (txn) => {

        var roomRef = db.collection('rooms').doc(roomId);

        await txn.update(roomRef, { 'phase': GameRoomPhase.lobby });
    });
}


async function submitTextImpl(roomId: string, userId: string, text: string) {
    await db.runTransaction(async (txn) => {

        var roomRef = db.collection('rooms').doc(roomId);

        var currentRoom = await txn.get(roomRef);

        var texts = currentRoom.data()!['texts'];
        var targets = currentRoom.data()!['targets'];

        texts[userId] = text;

        var numberOfSubmissions = Object.keys(text).length;
        var numberOfTargets = Object.keys(targets).length;

        if (numberOfSubmissions == numberOfTargets) {
            await txn
                .update(roomRef, { 'texts': texts })
                .update(roomRef, { 'phase': GameRoomPhase.selecting });
        }
        else {

            await txn.update(roomRef, { 'texts': texts });
        }

    });
}







async function handleCreatedUser(user: auth.UserRecord) {
    await _createPlayerProfile(user.uid);
}

async function _createPlayerProfile(uid: string) {

    logger.log('Creating user' + uid + '...');

    logger.log('User: "' + uid + '" created at ' + Date.now().toLocaleString);

    var createPlayer = db.collection('players').doc(uid).create({ 'id': uid });
    var createStatus = db.collection('playerStatuses').doc(uid).create({ 'id': uid });

    await Promise.all([createPlayer, createStatus]);
}


async function _setPlayerStatus(userId: string, message: string | null): Promise<void> {
    var updates;

    if (message == null) updates = { 'busy': false };
    else updates = { 'busy': true, 'messageWhileBusy': message };

    await db.collection('playerStatuses').doc(userId).update(updates);
}



// TODO: Max tries
async function _tryGenerateNewRoomCode(maxTries: number): Promise<string> {

    var newCode = generateRoomCode();

    var code = await db.runTransaction(async (txn) => {

        var whereRoomEqualsRoomCode = db.collection('rooms').where('roomCode', "==", newCode);

        var countQuery = whereRoomEqualsRoomCode.count();
        var countResult = await txn.get(countQuery);
        var count = countResult.data().count;

        if (count == 0) {
            return newCode;
        }
        else {
            return null;
        }
    });

    if (code == null) throw Error('error creating new room code');
    return code;
}




// Game

const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const numbers = '0123456789';

function generateRoomCode(): string {
    return [
        _getRandomCharacterFrom(alphabet),
        _getRandomCharacterFrom(alphabet),
        _getRandomCharacterFrom(alphabet),
        _getRandomCharacterFrom(numbers),
        _getRandomCharacterFrom(numbers),
    ].join('');
}

function _getRandomCharacterFrom(s: string): string {
    return s.charAt(_getRandomInt(s.length));
}

function _getRandomInt(max: number): number {
    return Math.floor((Math.random() * max));
}


// TODO: Adjust for case where allTruthsPossible == false
function _getTruthOrLieTargetMap(playerIds: string[]): Map<string, string> {

    var truthOrLieMap = new Map<string, boolean>();

    // Assign truth/lie randomly
    playerIds.forEach((p) => {
        truthOrLieMap.set(p, Math.random() < 0.5);
    });

    var liars = Array.from(truthOrLieMap.keys()).filter((k) => !truthOrLieMap.get(k));

    // Adjust for case where liars = 1
    if (liars.length == 1) {
        var truthers = Array.from(truthOrLieMap.keys()).filter((k) => truthOrLieMap.get(k));

        // Convert 1 random truther into a liar
        var randomIndex = Math.random() * truthers.length;
        var randomPlayerId = truthers.at(randomIndex)!;

        truthOrLieMap.set(randomPlayerId, false);
    }

    // Produce derangement of liars
    var liarIds = Array.from(truthOrLieMap.keys()).filter((k) => !truthOrLieMap.get(k));
    var numberOfLiars = liarIds.length;

    var derangement = _getDerangement(liarIds.length);

    var targets = new Array(numberOfLiars);
    for (var i = 0; i < numberOfLiars; i++) {
        targets[i] = liarIds[derangement[i]];
    }

    // Produce target map (including truth-tellers)
    var truthers = Array.from(truthOrLieMap.keys()).filter((k) => truthOrLieMap.get(k));
    var targetMap = new Map<string, string>();

    for (var i = 0; i < liarIds.length; i++) {
        targetMap.set(liarIds[i], targets[i]);
    }
    for (var i = 0; i < truthers.length; i++) {
        var truther = truthers[i];
        targetMap.set(truther, truther);
    }

    return targetMap;


}

// TODO: Implement derangement: https://gist.github.com/arrowsmith001/a0d1a622bdb88575d2b6189ad1cb42da
function _getDerangement(n: number): number[] {
    var baseList = Array.from(Array(n).keys());
    var out = Array.from(baseList);

    while (!_isDerangement(baseList, out)) {
        out = _shuffle(out);
    }

    return out;
}

function _shuffle(array: any[]): any[] {
    let currentIndex = array.length, randomIndex;

    // While there remain elements to shuffle.
    while (currentIndex != 0) {

        // Pick a remaining element.
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;

        // And swap it with the current element.
        [array[currentIndex], array[randomIndex]] = [
            array[randomIndex], array[currentIndex]];
    }

    return array;
}

function _isDerangement(list1: any[], list2: any[]): boolean {
    if (list1.length != list2.length) return false;

    var length = list1.length;

    for (var i = 0; i < length; i++) {
        if (list1[i] == list2[i]) return false;
    }

    return true;
}

