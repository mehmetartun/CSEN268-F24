// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBTlQODKj9KFSACf1AccZwPEzpGGCfHZeo',
    appId: '1:940129645525:web:3b27158c79d8b14bc6035c',
    messagingSenderId: '940129645525',
    projectId: 'fir-messaging-8b691',
    authDomain: 'fir-messaging-8b691.firebaseapp.com',
    storageBucket: 'fir-messaging-8b691.firebasestorage.app',
    measurementId: 'G-NKWSPG3EQ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCy9AQ88EwCvGuLw3wAg77fz0wwecS6-yk',
    appId: '1:940129645525:android:5114240a14dd8daec6035c',
    messagingSenderId: '940129645525',
    projectId: 'fir-messaging-8b691',
    storageBucket: 'fir-messaging-8b691.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoBvXxpHlcKhD4a_EZuO5stU4UiWISIjw',
    appId: '1:940129645525:ios:f881e9dd13e1c59ec6035c',
    messagingSenderId: '940129645525',
    projectId: 'fir-messaging-8b691',
    storageBucket: 'fir-messaging-8b691.firebasestorage.app',
    androidClientId: '940129645525-edi0n096njdlo515camt20n2jcdkurru.apps.googleusercontent.com',
    iosClientId: '940129645525-gfcgqj6bcatb74el8odas789q0jq9t52.apps.googleusercontent.com',
    iosBundleId: 'com.artun.fmdemo',
  );

}