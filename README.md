# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 15 - Cloud Functions and Serverless Computing
We explore Cloud Functions in Firebase using NodeJS

### Setting up Cloud Functions in your Project
Start with the command `firebase init`:
```zsh
MA@MBP:~/Development/csen268/CSEN268-F24> firebase init

     ######## #### ########  ######## ########     ###     ######  ########
     ##        ##  ##     ## ##       ##     ##  ##   ##  ##       ##
     ######    ##  ########  ######   ########  #########  ######  ######
     ##        ##  ##    ##  ##       ##     ## ##     ##       ## ##
     ##       #### ##     ## ######## ########  ##     ##  ######  ########

You're about to initialize a Firebase project in this directory:

  /Users/mehmetartun/Development/csen268/CSEN268-F24

Before we get started, keep in mind:

  * You are initializing within an existing Firebase project directory

? Which Firebase features do you want to set up for this directory? Press Space to select features, 
then Enter to confirm your choices. (Press <space> to select, <a> to toggle all, <i> to invert 
selection, and <enter> to proceed)
 ◯ Data Connect: Set up a Firebase Data Connect service
 ◯ Firestore: Configure security rules and indexes files for Firestore
 ◯ Genkit: Setup a new Genkit project with Firebase
❯◉ Functions: Configure a Cloud Functions directory and its files
 ◯ Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys
 ◯ Storage: Configure a security rules file for Cloud Storage
 ◯ Emulators: Set up local emulators for Firebase products
```
and select `Functions: Configure a Cloud Function...`
```zsh
You're about to initialize a Firebase project in this directory:

  /Users/mehmetartun/Development/csen268/CSEN268-F24

Before we get started, keep in mind:

  * You are initializing within an existing Firebase project directory

? Which Firebase features do you want to set up for this directory? Press Space to select features, 
then Enter to confirm your choices. Functions: Configure a Cloud Functions directory and its files

=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add, 
but for now we'll just set up a default project.

? Please select an option: (Use arrow keys)
❯ Use an existing project 
  Create a new project 
  Add Firebase to an existing Google Cloud Platform project 
  Don't set up a default project 
```
Select `Use an existing project` and `Javascript` for the language. Say `No` to `ESLint`. Say `Yes` to installing dependencies.
```zsh
? Select a default Firebase project for this directory: fir-messaging-8b691 (firebase-messaging)
i  Using project fir-messaging-8b691 (firebase-messaging)

=== Functions Setup
Let's create a new codebase for your functions.
A directory corresponding to the codebase will be created in your project
with sample code pre-configured.

See https://firebase.google.com/docs/functions/organize-functions for
more information on organizing your functions using codebases.

Functions can be deployed with firebase deploy.

? What language would you like to use to write Cloud Functions? JavaScript
? Do you want to use ESLint to catch probable bugs and enforce style? No
✔  Wrote functions/package.json
✔  Wrote functions/index.js
✔  Wrote functions/.gitignore
? Do you want to install dependencies with npm now? Yes
added 480 packages, and audited 481 packages in 11s
51 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities

i  Writing configuration info to firebase.json...
i  Writing project information to .firebaserc...

✔  Firebase initialization complete!
```

### Setting up Emulator
We need to create a service account to connect to the cloud functions. Go to the link:

[Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts)

And under your project you will see

[AppEngineService](/assets/images/ServiceAccountSetup.png) 

Open the item that says **App Engine Default Service Account** by clicking on the 
context menu on the right and selecting **Manage Keys**. 

In this page:

[Add Key](/assets/images/AddKeyPage.png)

Select **Add Key**, then **Create New Key**, and then select **JSON**.

[JSON](/assets/images/CreateJsonKey.png)

Save the file to your `functions` directory. And add this file to your `.gitignore` file. 
This file should not be in the public domain!

Finally, we create a shell script to run the emulator for functions
```zsh
export GOOGLE_APPLICATION_CREDENTIALS="/Users/mehmetartun/Development/csen268/CSEN268-F24/functions/fir-messaging-8b691-18ea76b9df31.json"
firebase emulators:start --only functions
```
In this repo we created [emulator_functions.sh](/emulator_functions.sh) and made it executable by running `chmod 755 emulator_functions.sh`.

### Importing Cloud Functions package and setting up the Flutter code
To add cloud functions:
```zsh
flutter pub add cloud_functions
```
and in your `main.dart` add:
```dart
FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
```

### Writing your first function
In the [index.js](/functions/index.js) file add the import:
```js
const {onCall} = require("firebase-functions/v2/https");
```
and our first function is:
```js
exports.helloWorld = onCall(async (request) => {
    logger.info("Call to Hello World Function.");
    return "Hello World";
})
```
It simply returns a string and also enters info into the logs.

### Accessing Cloud Functions from Flutter App
To access the Cloud Functions we create a page [functions_demo.dart](/lib/pages/functions_demo.dart).
The callable function is defined as:
```dart
  final HttpsCallable helloWorld =
      FirebaseFunctions.instance.httpsCallable('helloWorld');
```
it is then invoked by
```dart
  void callHelloWorld() async {
    HttpsCallableResult ret = await helloWorld.call({});
    result = ret.data['message'];
    setState(() {});
  }
```
Note that the argument to the `.call()` method is a `Map` and the returned result is the `data` property of the `HttpsCallableResult`.



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



