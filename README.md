# Santa Clara University - CSEN268 Fall 2024

## Lecture 11 - Firebase In-App Messaging Implementation

We change the bundleID and package name to `com.artun.fmdemo` which is defined for the Android and iOS apps in the firebase project 
`fir-messaging-8b691` nicknamed `firebase-messaging`. Formerly this was `com.example.lect4`

> You must enable Google Analytics for the project to be able to use In-App Messaging.

### Run flutterfire

```zsh
flutterfire configure -a com.artun.fmdemo -i com.artun.fmdemo
```
Chose only **iOS**, **Android**, and **Web**.

Now check that the package name is correct in the files.

### Imports
```zsh
flutter pub add firebase_core firebase_in_app_messaging firebase_app_installations
```

Add these into your main.dart file.

### Getting installation ID

Make your `main()` async and add these before calling `runApp`
```dart
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(await FirebaseInstallations.instance.getId());
```

## Issue with iOS Target

Change the minimum deployment to 14 in the `Podfile`

## Change Homepage 

Create `messaging_page.dart` and create a Stateless Widget with Scaffold. 

![Messaging Page](/assets/images/MessagingPage.png)

## Test message

Go to Messaging in Firebase Console

![Messaging In App](/assets/images/FIAM1.png)

Create a test message

![Messaging In App](/assets/images/FIAM2.png)

![Messaging In App](/assets/images/FIAM3.png)

![Messaging In App](/assets/images/FIAM4.png)

Then save as draft. And then publish by clicking on it.

![Publishing Campaign](/assets/images/FIAM6.png)


Copy the **id** printed out by Firebase app installations `e1GznI84skEnu_KZFNWXZTz` (yours will be different)
and open the draft campaign in **View** mode  and click **Test on Device**.

![Messaging In App](/assets/images/FIAM5.png)

Now kill the app. And restart.

![In-App Message](/assets/images/FIAM7.png)






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



