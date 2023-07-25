
import * as firestore from "firebase-admin/firestore";
import * as auth from "firebase-admin/auth";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";

//import * as https from "firebase-functions/v2/https";

import * as functionsv1 from "firebase-functions";
//import * as functionsv2 from "firebase-functions/v2";
import * as http from 'firebase-functions/v2/https';
import { UserRecord } from "firebase-functions/v1/auth";
//import * as express from "express";

const app = admin.initializeApp();
const firestoreInstance = firestore.initializeFirestore(app);

// TODO: Just for testing
exports.invokeOnUserCreate = http.onCall(
    async (req: http.CallableRequest) => {

        var id = req.data;
        var user = await auth.getAuth().getUser(id);
        await _handleCreatedUser(user);
    });


exports.onUserCreated = functionsv1.auth.user().onCreate(_handleCreatedUser);


async function _handleCreatedUser(user: UserRecord): Promise<void> {
    await createPlayerProfile(user.uid);
}


// TODO: Implement createGameRoom
exports.createGameRoom = http.onCall(
    async (req: http.CallableRequest) => {

        var userId = req.data as string;
        var roomCode = 'ABC48';

        var newRoom = { 'roomCode': roomCode, 'playerIds': [userId] };
        var docRef = await firestoreInstance.collection('rooms').add(newRoom);

        await docRef.update({ 'id': docRef.id });
        await firestoreInstance.collection('players').doc(userId).update({ 'occupiedRoomId': docRef.id });

    });

// TODO: Implement joinGameRoom
exports.joinGameRoom = http.onCall(
    (req: http.CallableRequest) => {

        logger.log('req : ' + req.data);

    });

/*
exports.joinGameRoom = async function (userId: string, roomCode: string) {
         var docRef = await firestoreInstance.collection('rooms').where();
        await docRef.update({ 'id': docRef.id });
        await firestoreInstance.collection('players').doc(userId).update({ 'occupiedRoomId': docRef.id });
} */

// Blocking
/* exports.onUserCreated = functionsv2.identity.beforeUserCreated(async event => {
    await createPlayerProfile('event.data.uid');
}); */

async function createPlayerProfile(uid: string) {

    logger.log('User: "' + uid + '" created at ' + Date.now().toLocaleString);
    await firestoreInstance.collection('players').doc(uid).create({ 'id': uid });
}