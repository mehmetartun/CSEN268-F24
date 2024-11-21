# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 18 - Flutter Web, WebView and Ads
In this lecture we will explore Flutter Web, WebView and Ads

### Step 00 - Start with a generic page and deploy to web
We point to a generic page titled **Welcome to Web** and we will deploy this to the web.

#### Build for Web
We first build our project for web:
```zsh
>>> flutter build web

Font asset "CupertinoIcons.ttf" was tree-shaken, reducing it from 257628 to 1172 bytes (99.5% reduction).
Tree-shaking can be disabled by providing the --no-tree-shake-icons flag when building your app.
Font asset "MaterialIcons-Regular.otf" was tree-shaken, reducing it from 1645184 to 7692 bytes (99.5%
reduction). Tree-shaking can be disabled by providing the --no-tree-shake-icons flag when building your app.
Compiling lib/main.dart for the Web...                             18.3s
✓ Built build/web
```

#### Setup Hosting configuration
To deploy to **Firebase Hosting** you need to run **firebase init** in order to set up hosting configuration to your [firebase.json](/firebase.json) file:
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

? Which Firebase features do you want to set up for this directory? Press Space to select features, then Enter
 to confirm your choices. (Press <space> to select, <a> to toggle all, <i> to invert selection, and <enter> to
 proceed)
 ◯ Genkit: Setup a new Genkit project with Firebase
 ◯ Functions: Configure a Cloud Functions directory and its files
 ◯ App Hosting: Configure an apphosting.yaml file for App Hosting
❯◯ Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys
 ◯ Storage: Configure a security rules file for Cloud Storage
 ◯ Emulators: Set up local emulators for Firebase products
 ◯ Remote Config: Configure a template file for Remote Config
(Move up and down to reveal more choices)
```
after that you need to specify your **public** directory. This will be `/build/web` for a Flutter project:
```zsh
=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add, 
but for now we'll just set up a default project.

i  Using project fir-messaging-8b691 (firebase-messaging)

=== Hosting Setup

Your public directory is the folder (relative to your project directory) that
will contain Hosting assets to be uploaded with firebase deploy. If you
have a build process for your assets, use your build's output directory.

? What do you want to use as your public directory? build/web
? Configure as a single-page app (rewrite all urls to /index.html)? (y/N) y
? Set up automatic builds and deploys with GitHub? (y/N) N
? File build/web/index.html already exists. Overwrite? (y/N) N
```

Now your [firebase.json](/firebase.json) contains hosting configuration:
```json
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
```

#### Deploying
```zsh
firebase deploy --only hosting

=== Deploying to 'fir-messaging-8b691'...

i  deploying hosting
i  hosting[fir-messaging-8b691]: beginning deploy...
i  hosting[fir-messaging-8b691]: found 32 files in build/web
✔  hosting[fir-messaging-8b691]: file upload complete
i  hosting[fir-messaging-8b691]: finalizing version...
✔  hosting[fir-messaging-8b691]: version finalized
i  hosting[fir-messaging-8b691]: releasing new version...
✔  hosting[fir-messaging-8b691]: release complete

✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/fir-messaging-8b691/overview
Hosting URL: https://fir-messaging-8b691.web.app
```

#### Accessing the Web App
The web app will be located at [fir-messaging-8b691.web.app](https://fir-messaging-8b691.web.app/)

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



