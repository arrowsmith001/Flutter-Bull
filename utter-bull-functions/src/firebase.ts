
/* import * as firestore from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import * as auth from "firebase-admin/auth";
import * as logger from "firebase-functions/logger";
import * as promises from 'node:timers/promises';

import * as functionsv1 from "firebase-functions";



const delaysOn = false;

const app = admin.initializeApp();
const db = firestore.initializeFirestore(app); */



/* export function getAuth() {
    return functionsv1.auth;
}


export async function onUserCreateInvoked(id: string) {
    var user = await auth.getAuth().getUser(id);
    await handleCreatedUser(user);
}


export async function createGameRoomFirebase(userId: string) {

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

export async function joinGameRoomFirebase(userId: string, roomCode: string) {

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

export async function removeFromRoomFirebase(userId: string, roomId: string) {

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



export async function handleCreatedUser(user: auth.UserRecord) {
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
} */