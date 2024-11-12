const {logger} = require("firebase-functions/v2");
const {
    onRequest,
    onCall,
    HttpsError
} = require("firebase-functions/v2/https");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, Timestamp } = require("firebase-admin/firestore");
const {
    onDocumentWritten,
    onDocumentCreated,
    onDocumentDeleted,
    onDocumentUpdated,
    Change,
    FirestoreEvent
} = require("firebase-functions/v2/firestore");

initializeApp()

module.exports  = {
    onRequest,
    onCall,
    HttpsError,
    getFirestore,
    Timestamp,
    onDocumentWritten,
    onDocumentCreated,
    onDocumentDeleted,
    onDocumentUpdated,
    Change,
    FirestoreEvent,
    logger
}