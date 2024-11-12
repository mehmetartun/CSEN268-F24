# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 15 - Cloud Functions and Serverless Computing
We explore Cloud Functions in Firebase using NodeJS.

### Step 5 - Firestore triggers
As part of the serverless computing appeal of Firebase, we can create **Firestore triggers**. These are can be thought of listeners to the Firestore database which trigger a cloud function when a specified event occurs.

Let's consider that we want to create a `log` collection where we enter the path to the `user` document as well as the time it was created. This can be facilitated by the `onDocumentCreated`.

Import this in the [init.js](/functions/init.js) document:
```js
const {
    ...
    onDocumentCreated,
    ...
} = require("firebase-functions/v2/firestore");

module.exports  = {
    ...
    onDocumentCreated,
    ...
}
```
and import them into [db.js](/functions/db.js):
```js
const { 
    ...
    onDocumentCreated,
 } = require("./init.js");
 ```

 We then create a function:
 ```js
 exports.onUserCreated = onDocumentCreated("/users_test/{userId}", async (event) => {
    await getFirestore().collection('log')
    .add({
        'userPath':event.data.ref.path,
        'createdAt':event.data.createTime,
        'id':event.data.ref.id
    });
});
 ```
 Here we look for a pattern of the form `/users_test/userId` and we can get a handle on the specific `userId` of the user by:
 ```js
 const userId = event.data.params.userId;
 ```
 
 It could as well be the case where you have a `user` that adds a `car` to this `cars` collection. In this case you could match a car by `carId` and at to the `log` collection:
 ```js
  exports.onCarAdded = onDocumentCreated("/users_test/{userId}/cars/{carId}", async (event) => {
    await getFirestore().collection('log')
    .add({
        'userId':event.params.userId,
        'carId': event.params.licencePlate,
        'createdAt':event.data.createTime,
    });
});
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



