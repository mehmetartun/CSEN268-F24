const {logger} = require("firebase-functions/v2");
const {onRequest} = require("firebase-functions/v2/https");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {onCall} = require("firebase-functions/v2/https");

initializeApp()

module.exports  = {
    onRequest,
    getFirestore,
    onCall,
    logger
}