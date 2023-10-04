

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


const subphaseStartVoting = 4;


const delaysOn = false;

const app = admin.initializeApp();
const db = firestore.initializeFirestore(app);


// TODO: Listeners
// Listen for text changes
functionsv1.firestore.document('rooms/aBXFsSNDr5WAGFjX6gQ0').onUpdate((snapshot) => {
    console.log('hello!');
});





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

        try {

            await startGameImpl(roomId);
        }
        catch (e) {
            console.log(e);
        }
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
        var text = req.data['text'];

        submitTextImpl(roomId, userId, text);
    });



export const startRound = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var userId = req.data['userId'] as string;

        await startRoundImpl(roomId, userId);
    });

export const vote = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var userId = req.data['userId'] as string;
        var truthOrLie = req.data['truthOrLie'] as boolean;

        await voteImpl(roomId, userId, truthOrLie);
    });

export const endRound = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var userId = req.data['userId'] as string;

        await endRoundImpl(roomId, userId);
    });

export const reveal = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var userId = req.data['userId'] as string;

        await revealImpl(roomId, userId);
    });

export const revealNext = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var userId = req.data['userId'] as string;

        await revealNextImpl(roomId, userId);
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

export const setSubPhase = http.onCall(
    async (req: http.CallableRequest) => {

        var roomId = req.data['roomId'] as string;
        var phaseNum = req.data['phaseNum'] as number;

        await setSubPhaseImpl(roomId, phaseNum);
    });

// export const calculateResults = http.onCall(
//     async (req: http.CallableRequest) => {

//         var roomId = req.data['roomId'] as string;

//         await _calculateResults(roomId);
//     });







async function onUserCreateInvoked(id: string) {
    var user = await auth.getAuth().getUser(id);
    await handleCreatedUser(user);
}


async function createGameRoomImpl(userId: string) {

    await _trySetPlayerStatus(userId, 'Creating Game Session');
    if (delaysOn) promises.setTimeout(1000);

    await db.runTransaction(async (txn) => {

        var newCode = await _tryGenerateNewRoomCode(5);

        var newRoomDoc = db.collection('rooms').doc();
        var playerDoc = db.collection('players').doc(userId);

        var newRoom = {
            'id': newRoomDoc.id,
            'roomCode': newCode,
            'playerIds': [userId],
            'phase': 0,
            'subPhase': 0,
            'settings':
            {
                'roundTimeSeconds': 60 * 3
            }
        };
        var playerUpdates = { 'occupiedRoomId': newRoomDoc.id };

        await txn
            .create(newRoomDoc, newRoom)
            .update(playerDoc, playerUpdates);


    });

    await _trySetPlayerStatus(userId, null);

}

async function joinGameRoomImpl(userId: string, roomCode: string) {

    await _trySetPlayerStatus(userId, 'Joining Game Session');
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

    await _trySetPlayerStatus(userId, null);

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
    lobby, writing, round, reveals, results
}

// TODO: Ensure player cannot join while starting game
async function startGameImpl(roomId: string) {

    await db.collection('rooms').doc(roomId).update({ 'state': 'startingGame' });

    await db.runTransaction(async (txn) => {

        var roomRef = db.collection('rooms').doc(roomId);

        var roomQuery = await txn.get(roomRef);
        var room = roomQuery.data();

        // TODO: Allow for spectators
        var playerIds = room!['playerIds'] as string[];

        // Generate targets map
        var targets = _getTruthOrLieTargetMap(playerIds);
        var truths = new Map(Array.from(targets).map((([k, v]) => [k, k == v])));

        // Generate empty texts
        var texts = new Map<String, String>();

        // Generate random player order
        var playerOrder = Array.from(playerIds);
        _shuffleArray(playerOrder);

        // Generate empty votes & vote times
        var votes = new Map<String, String[]>(Array.from(playerIds, (id) => [id, playerOrder.map((orderId) => orderId == id ? 'p' : '-')]));
        var voteTimes = new Map<String, Number[]>(Array.from(playerIds, (id) => [id, playerOrder.map((orderId) => orderId == id ? -999 : -1)]));

        txn
            .update(roomRef, { 'targets': Object.fromEntries(targets) })
            .update(roomRef, { 'truths': Object.fromEntries(truths) })
            .update(roomRef, { 'votes': Object.fromEntries(votes) })
            .update(roomRef, { 'voteTimes': Object.fromEntries(voteTimes) })
            .update(roomRef, { 'texts': Object.fromEntries(texts) })
            .update(roomRef, { 'playerOrder': playerOrder })
            .update(roomRef, { 'progress': 0 })
            .update(roomRef, { 'phase': GameRoomPhase.writing })
            .update(roomRef, { 'subPhase': 0 });
    });


    await db.collection('rooms').doc(roomId).update({ 'state': null });

}

async function returnToLobbyImpl(roomId: string) {
    await db.runTransaction(async (txn) => {

        var roomRef = db.collection('rooms').doc(roomId);

        txn.update(roomRef, { 'phase': GameRoomPhase.lobby, 'subPhase': 0 });
    });
}


async function submitTextImpl(roomId: string, userId: string, text: string) {
    await db.runTransaction(async (txn) => {


        var roomRef = db.collection('rooms').doc(roomId);
        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        // TODO: Check if phase is appropriate!!

        var texts = currentRoomData['texts'];
        var targets = currentRoomData['targets'];

        var target = targets[userId];
        texts[target] = text;

        txn.update(roomRef, { 'texts': texts });

        // Check text submission progress
        var numberOfSubmissions = Object.values(texts).filter(t => t != null).length;
        var numberOfTargets = Object.keys(targets).length;

        if (numberOfSubmissions == numberOfTargets) {
            txn.update(roomRef, { 'phase': GameRoomPhase.round });
        }

    });
}


async function startRoundImpl(roomId: string, userId: string) {

    var roomRef = db.collection('rooms').doc(roomId);

    await db.runTransaction(async (txn) => {

        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        var totalTime = currentRoomData['settings']['roundTimeSeconds'];

        // TODO: Account for time zones!!
        var roundEndTime = Date.now().valueOf() + (totalTime * 1000);

        txn.update(roomRef, { 'roundEndUTC': roundEndTime, 'subPhase': subphaseStartVoting });

    });

}

async function voteImpl(roomId: string, userId: string, truthOrLie: boolean) {

    var roomRef = db.collection('rooms').doc(roomId);

    await db.runTransaction(async (txn): Promise<void> => {

        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        // Calculate time taken to vote
        var roundEndUTC = currentRoomData['roundEndUTC'];
        var roundTimeSeconds: number = currentRoomData['settings']['roundTimeSeconds'];
        var timeTakenToVoteMilliseconds: number = (roundTimeSeconds * 1000) - (roundEndUTC - Date.now().valueOf());
        var timeTakenToVoteSeconds = Math.floor(timeTakenToVoteMilliseconds / 1000);

        // Clamp time value
        timeTakenToVoteSeconds = Math.max(timeTakenToVoteSeconds, 0);
        timeTakenToVoteSeconds = Math.min(timeTakenToVoteSeconds, roundTimeSeconds);

        // Get appropriate vote entry symbol
        var progress = currentRoomData['progress'] as number;
        var thisPlayersVotes = currentRoomData['votes'][userId];
        var symbolAtProgress = thisPlayersVotes[progress];

        // If player is able to vote
        if (symbolAtProgress == '-') {

            var voteSymbol = truthOrLie ? 't' : 'l';

            currentRoomData['votes'][userId][progress] = voteSymbol;
            currentRoomData['voteTimes'][userId][progress] = timeTakenToVoteSeconds;

            console.log('Adding vote ' + voteSymbol + ' for ' + userId + ' in ' + roomId);

            txn.update(roomRef, { 'votes': currentRoomData['votes'] });
            txn.update(roomRef, { 'voteTimes': currentRoomData['voteTimes'] });
        }
        else if (symbolAtProgress == 'p') {
            console.log('Error voting: ' + userId + ' cant vote for self');
        }
        else {
            console.log('Error voting: ' + userId + ' in ' + roomId + ' - already voted ' + symbolAtProgress);
        }

        // Check votes progress
        var votes = Object.values<Array<String>>(currentRoomData['votes']);
        console.log(votes);

        var allVoted = votes.every((v) => v[progress] != '-');
        if (allVoted) {
            // End round
            txn.update(roomRef, { 'roundEndUTC': 0 });
        }


    });

}



async function endRoundImpl(roomId: string, userId: string) {

    var roomRef = db.collection('rooms').doc(roomId);
    var goToReveals = false;

    await db.runTransaction(async (txn) => {

        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        var playerOrder = Array.from(currentRoomData['playerOrder']);
        var progress = currentRoomData['progress'];

        var votes = currentRoomData['votes'];

        for (var key in Object.keys(votes)) {

            // I don't know why this is returning an integer array index as a String, and not a playerId
            var index = Number.parseInt(key);

            var voteArray = Object.values(votes).at(index) as String[];

            if (voteArray[progress] == '-') {
                voteArray[progress] = 'n';
            }
        }

        progress += 1;

        if (playerOrder.length <= progress) {

            goToReveals = true;

            txn.update(roomRef, { 'votes': currentRoomData['votes'] });
        }
        else {

            txn
                .update(roomRef, { 'votes': currentRoomData['votes'] })
                .update(roomRef, { 'progress': progress, 'subPhase': 0 });
        }
    });

    if (goToReveals) {
        //await _calculateResults(roomId);

        await db.runTransaction(async (txn) => {
            txn
                .update(roomRef, { 'progress': 0, 'subPhase': 0, 'phase': GameRoomPhase.reveals });
        });
    }

}

// TODO: Add more validation
// If subPhase == 0 -> subPhase set to 1
async function revealImpl(roomId: string, userId: string) {

    var roomRef = db.collection('rooms').doc(roomId);

    await db.runTransaction(async (txn) => {

        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        var currentSubPhase = currentRoomData.subPhase as number;

        if (currentSubPhase == 0) {

            txn
                .update(roomRef, { 'subPhase': 1 });
        }

    });
}

// Check progress. If appropriate, increment progress. Else, advance phase to Results.
async function revealNextImpl(roomId: string, userId: string) {
    var roomRef = db.collection('rooms').doc(roomId);

    await db.runTransaction(async (txn) => {

        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        var playerOrder = currentRoomData['playerOrder'] as [];

        var numberOfPlayers = playerOrder.length;

        var progress = currentRoomData['progress'] as number;
        progress++;

        if (numberOfPlayers <= progress) {
            txn
                .update(roomRef, { 'phase': GameRoomPhase.results });
        }
        else {
            txn
                .update(roomRef, { 'progress': progress, 'subPhase': 0 });

        }

    });
}


async function setSubPhaseImpl(roomId: string, phaseNum: number) {

    var roomRef = db.collection('rooms').doc(roomId);

    await db.runTransaction(async (txn) => {

        var currentRoom = await txn.get(roomRef);
        var currentRoomData = currentRoom.data()!;

        var currentSubPhase = currentRoomData['subPhase'] as number;

        if (currentSubPhase != phaseNum) {

            txn
                .update(roomRef, { 'subPhase': phaseNum });
        }

    });
}


async function handleCreatedUser(user: auth.UserRecord) {
    await _createPlayerProfile(user.uid);
}

async function _createPlayerProfile(uid: string) {

    logger.log('Creating user' + uid + '...');

    logger.log('User: "' + uid + '" created at ' + Date.now().toLocaleString());

    var createPlayer = db.collection('players').doc(uid).create({ 'id': uid });
    var createStatus = db.collection('playerStatuses').doc(uid).create({ 'id': uid });

    await Promise.all([createPlayer, createStatus]);
}


// TODO: Decide how important this is
async function _trySetPlayerStatus(userId: string, message: string | null): Promise<void> {

    var updates;

    if (message == null) updates = { 'busy': false };
    else updates = { 'busy': true, 'messageWhileBusy': message };

    try {
        await db.collection('playerStatuses').doc(userId).update(updates);
    }
    catch (e) {

    }
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
        var isTruth = Math.random() < 0.5;
        truthOrLieMap.set(p, isTruth);
    });

    var liars = Array.from(truthOrLieMap.keys()).filter((k) => !truthOrLieMap.get(k));

    console.log('_getTruthOrLieTargetMap 1: ' + JSON.stringify(liars));

    // TODO: Tie this to an optional setting ("All Truths Allowed")
    if (liars.length == 0) {
        // Switch 2 to liars
        var playersTemp = Array.from(playerIds);
        var randomIndex1 = Math.random() * playersTemp.length;
        var firstToSwitch = playersTemp[randomIndex1];

        playersTemp.filter(id => id != firstToSwitch);
        var randomIndex2 = Math.random() * playersTemp.length;
        var secondToSwitch = playersTemp[randomIndex2];

        truthOrLieMap.set(firstToSwitch, false);
        truthOrLieMap.set(secondToSwitch, false);

        console.log('truthOrLieMap 1: ' + JSON.stringify(truthOrLieMap));
    }
    // Adjust for case where liars = 1
    else if (liars.length == 1) {
        var truthers = Array.from(truthOrLieMap.keys()).filter((k) => truthOrLieMap.get(k));

        // Convert 1 random truther into a liar
        var randomIndex = Math.random() * truthers.length;
        var randomPlayerId = truthers.at(randomIndex)!;

        truthOrLieMap.set(randomPlayerId, false);

        console.log('truthOrLieMap 2: ' + JSON.stringify(truthOrLieMap));
    }

    // Produce derangement of liars
    var liarIds = Array.from(truthOrLieMap.keys()).filter((k) => !truthOrLieMap.get(k));
    var numberOfLiars = liarIds.length;

    var targets = new Array(numberOfLiars);


    if (numberOfLiars > 0) {
        var derangement = _getDerangement(liarIds.length);
        console.log('derangement 1: ' + JSON.stringify(derangement));

        for (var i = 0; i < numberOfLiars; i++) {
            targets[i] = liarIds[derangement[i]];
        }
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

    console.log('Returning target map: ' + JSON.stringify(targetMap));

    return targetMap;


}

function _getDerangement(n: number): number[] {

    console.log('_getDerangement: n:' + n);

    var baseList: number[] = Array.from({ length: n }, (_, i) => i);
    var out: number[] = [...baseList];

    function findFixedIndices(arr: number[]): number[] {
        var fixedIndices: number[] = [];
        for (var i = 0; i < arr.length; i++) {
            if (i == arr[i]) fixedIndices.push()
        }
        return fixedIndices;
    }

    _shuffleArray(out);

    var fixedIndices: number[] = findFixedIndices(out);

    console.log('_getDerangement: out: ' + out);
    console.log('_getDerangement: fixedIndices: ' + fixedIndices);

    if (fixedIndices.length == 0) {
        return out; // Derangement found
    }

    if (fixedIndices.length == 1) {
        // Swap with some other random element
        const single = fixedIndices[0];
        const remaining = out.filter((val) => val !== single);
        const randomIndex = Math.floor(Math.random() * remaining.length);
        const toSwapWith = remaining[randomIndex];

        out[single] = toSwapWith;
        out[out.indexOf(toSwapWith)] = single;

        return out;
    }

    if (fixedIndices.length == 2) {
        // Swap the 2 elements
        [out[fixedIndices[0]], out[fixedIndices[1]]] = [out[fixedIndices[1]], out[fixedIndices[0]]];
        return out;
    }

    // Generate a derangement of the remaining non-fixed-point elements
    var subDerangement = _getDerangement(fixedIndices.length);

    for (let i = 0; i < n; i++) {
        if (fixedIndices.includes(i)) {
            const indexWhere = fixedIndices.indexOf(i);
            out[i] = subDerangement[indexWhere];
        }
    }
    return out;

}


function _shuffleArray(array: any[]): void {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
}

// class Achievements {
//     static fooledAll = 'fooledAll';
//     static fooledMost = 'fooledMost';
//     static fooledSome = 'fooledSome';
//     static votedCorrectly = 'votedCorrectly';
//     static votedCorrectlyInMinority = 'votedCorrectlyInMinority';
//     static votedCorrectlyQuickest = 'votedCorrectlyQuickest';
// }

// async function _calculateResults(roomId: string) {

//     var roomRef = db.collection('rooms').doc(roomId);
//     //var achievementsRef = db.collection('achievements');
//     var resultsRef = db.collection('results');

//     await db.runTransaction(async (txn) => {

//         var roomQuery = await txn.get(roomRef);
//         var room = roomQuery.data()!;

//         // TODO: Calculate

//         const order = room['playerOrder'] as string[];
//         const votes = room['votes'];
//         const truths = room['truths'];

//         console.log(order);
//         console.log(votes);
//         console.log(truths);


//         const numberOfRounds = order.length;

//         const achievementsByRound = [];

//         // For each round...
//         for (let roundNum = 0; roundNum < numberOfRounds; roundNum++) {

//             const achievements: { [k: string]: any } = {};

//             var playerWhoseTurn = order[roundNum];
//             var truthThisRound = room['truths'][playerWhoseTurn];

//             var numberVotedTrue = 0;
//             var numberVotedFalse = 0;
//             var numberOfEligibleVoters = 0;

//             // Count votes & voters
//             order.forEach((playerId) => {

//                 var vote = votes[playerId][roundNum];

//                 if (vote != 'p') {
//                     numberOfEligibleVoters++;
//                 }

//                 switch (vote) {
//                     case 't':
//                         numberVotedTrue++;
//                         break;
//                     case 'l':
//                         numberVotedFalse++;
//                         break;
//                 }
//             });

//             var numberVotedCorrectly = truthThisRound ? numberVotedTrue : numberVotedFalse;
//             var proportionVotedCorrectly = numberVotedCorrectly / numberOfEligibleVoters;

//             // For each player, calculate achievements...
//             order.forEach((playerId) => {

//                 const playerAchievements: string[] = [];


//                 var vote = votes[playerId][roundNum];

//                 switch (vote) {
//                     case 't':
//                         if (truthThisRound) {
//                             playerAchievements.push(Achievements.votedCorrectly);
//                         }
//                         break;
//                     case 'l':
//                         if (!truthThisRound) {
//                             playerAchievements.push(Achievements.votedCorrectly);
//                         }
//                         break;
//                     case 'p':

//                         if (numberVotedCorrectly == 0) {
//                             playerAchievements.push(Achievements.fooledAll)
//                         }
//                         else if (proportionVotedCorrectly < 0.5) {
//                             playerAchievements.push(Achievements.fooledMost);
//                         }
//                         else if (numberVotedCorrectly != numberOfEligibleVoters) {
//                             playerAchievements.push(Achievements.fooledSome);
//                         }

//                         break;
//                 }


//                 achievements[playerId] = playerAchievements;
//             });

//             achievementsByRound.push({ 'playersToAchievements': achievements });

//         }

//         const newDoc = resultsRef.doc();

//         const data = {
//             'id': newDoc.id,
//             'result': achievementsByRound,
//             'timeCreatedUTC': Date.now().valueOf()
//         };

//         const map = JSON.stringify(data);

//         const json = JSON.parse(map);

//         console.log(json);


//         txn.create(newDoc, json)
//             .update(roomRef, { 'resultId': newDoc.id });;


//         // TODO: Serialize!
//         // TODO: Include round scores

//     });





// }
/* function _substituteCharAt(str: string, pos: number, char: string): string {
    return str.substring(0, pos) + char + str.substring(pos + 1);
} */

