# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 15 - Cloud Functions and Serverless Computing
We explore Cloud Functions in Firebase using NodeJS.

### Step 4 - Organizing Cloud Functions


It's common practice to organize the cloud functions by namespace for easier management. For this, we create two namespaces. One will be called `misc` and the other `db` referring to miscellaneous functions and database functions respectively. Our `helloWorld` will fall in the `misc` category and `addData` and `getData` will fall in the `db` category. We shall also create an `init.js` file to do all initializations, especially Firebase.


#### Modify the `index.js` file
```js
exports.misc = require('./misc.js');
exports.db = require('./db.js');
```

#### Create the `init.js`, `misc.js`, and `db.js` files
```js
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
```

Then for the namespace `misc` we have [misc.js](/functions/misc.js):
```js
const { 
    logger,
    onCall,
} = require("./init.js");

exports.helloWorld = onCall(async (request) => {
    logger.info("Call to Hello World Function.");
    console.log(request.auth);
    return {message: "Hello World"};
})
```
And for the namespace `db` we have [db.js](/functions/db.js):
```js
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
```

#### Calling the functions with the new namespace
With the new namespace the calling of the functions become slightly different
```dart
  final HttpsCallable helloWorld =
      FirebaseFunctions.instance.httpsCallable('misc-helloWorld');
```
where the function name gets `<namespace>-` in front.

#### Deploying functions with the namespace
To deploy functions we have the option to specify only the namespace to deploy all functions in that namespace and not others:
```zsh
firebase deploy --only functions:db
```

### Setting up your environment before the lecture

Each lecture is stored under a separate tag. On your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click the Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull the requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



