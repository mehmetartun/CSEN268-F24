/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const {onCall} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const { getFirestore } = require("firebase-admin/firestore");
const {initializeApp} = require("firebase-admin/app");


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

initializeApp();


exports.helloWorld = onCall(async (request) => {
    logger.info("Call to Hello World Function.");
    return {message: "Hello World"};
})

exports.addData = onCall(async (request)=> {
    const collection = request.data['collection'];
    const map = request.data['map'];
    var documentReference = await getFirestore().collection(collection).add(map);
    return {'path': documentReference.path, 'id': documentReference.id};
})

exports.getData = onCall(async (request)=> {
    const path = request.data['path'];
    var doc = await getFirestore().doc(path).get();
    return doc.data();
})