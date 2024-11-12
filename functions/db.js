const { 
    logger,
    getFirestore,
    onCall
 } = require("./init.js");

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