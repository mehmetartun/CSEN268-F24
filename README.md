# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Firebase Authentication - Apple SignIn, Google SignIn and Email SignIn
We implement raw Firebase Authentication with Apple SignIn, Google SignIn and Email SignIn.
We remove all dependencies from the project:
- Firebase Storage
- Firebase Messaging
- Google Maps
- Shimmer
- Google Analytics
- Geolocator
- Contacts
- Image Picker
and we also remove
- AuthenticationRepository
- Notifications Bloc
- Save Image Service
and turn it into a lightweight project where we will implement Firebase Ui Auth from scratch.

In order to prevent pod installation in future steps, we import 3 dependencies at this step:
```zsh
flutter pub add google_sign_in sign_in_button firebase_auth
```
To run, you will be required to change the `minSdk` to `23` in [build.gradle](/android/app/build.gradle).

### Go Router

The `router` is pointing to `/` and that's the only Route that exists in the app.

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



