# Santa Clara University - CSEN268 Fall 2024

## Lecture 11 - Firebase Cloud Messaging Web Modification

We need to implement a slightly different flow for web. 

1. Add the service worker for firebase messaging [firebase-messaging-sw.js](/web/firebase-messaging-sw.js) in the `web` directory. 

2. Modify the `onBackgroundMessage` to handle web differently
```dart
  if (kIsWeb) {
    FirebaseMessaging.onBackgroundMessage((message) async {
      // Do what you need to do with the message
    });
  } else {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
```
The `kIsWeb` is a boolean that's `true` for Web and `false` otherwise.





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



