# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 15 - Cloud Functions and Serverless Computing
We explore Cloud Functions in Firebase using NodeJS

### Step 2 - Interacting with Firestore
In this section we will interact with Firestore from Cloud Functions

#### Add Firestore
We add Firestore to our [index.js](/functions/index.js) file by adding this at the top:
```js
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
```
#### Syntax for Cloud Functions
The functions callable from the App use the `onCall` method. The syntax is:
```js
exports.functionName = onCall(async (request)=>{
  ...
})
```
Here the `request` object has a number of members. One of these is `data` which contains the parameters passed from the App. The other one is `auth` which gives the info on the authenticated user making the call.

Next we create a function to write the data that's sent from the Flutter App:
```js
exports.addData = onCall(async (request)=> {
    const collection = request.data['collection'];
    const map = request.data['map'];
    var documentReference = await getFirestore().collection(collection).add(map);
    return {'path': documentReference.path, 'id': documentReference.id};
})
```

Finally we create a function which reads data from a `path` and returns to the App:
```js
exports.getData = onCall(async (request)=> {
    const path = request.data['path'];
    var doc = await getFirestore().doc(path).get();
    return doc.data();
})
```

#### Calling from Flutter
To call these functions from Flutter we pass a `Map` for the content of the document we're creating, in this case a **user**, as well as the name of the collection where this will be inserted. In the retrieval, we receive the result in the `.data` property of the `HttpsCallableResult`.
```dart
  void callAddData() async {
    HttpsCallableResult ret = await addData.call({
      'collection': 'user_test',
      'map': {'name': 'John Doe', 'id': 123}
    });
    path = ret.data['path'];
    snack("path: ${ret.data['path']} id: ${ret.data['id']}");
  }

  void callGetData() async {
    HttpsCallableResult ret = await getData.call({'path': path});
    snack("name: ${ret.data['name']}   id: ${ret.data['id']}");
  }
```

### Setting up your environment before the lecture

Each lecture is stored under a separate tag. In your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list you all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



