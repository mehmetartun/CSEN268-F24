# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Step Implement Google Sign In
We start by adding `google_sign_in`:
```zsh
flutter pub add google_sign_in
```
And for the appropriate button we import the package `sign_in_button`:
```zsh
flutter pub add sign_in_button
```

```zsh
MA@MBP:~> keytool -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
Enter keystore password:  android
Alias name: androiddebugkey
Creation date: 2 Oct 2022
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Sun Oct 02 03:29:52 PDT 2022 until: Tue Sep 24 03:29:52 PDT 2052
Certificate fingerprints:
	 SHA1: 50:53:70:36:A6:4A:27:F1:CF:73:FC:AF:0E:EE:BB:08:A8:E7:EF:B0
	 SHA256: B7:B5:52:C3:02:1D:2F:1B:58:37:91:B2:28:4D:58:F9:87:29:0F:82:F1:C7:CF:FB:CF:45:0F:B9:D9:6A:67:44
Signature algorithm name: SHA1withRSA (weak)
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1

Warning:
The certificate uses the SHA1withRSA signature algorithm which is considered a security risk. This algorithm will be disabled in a future update.
```
### Implementing the Google SignIn in the Cubit
In our cubit, we create a function for Google Sign In that gets us the user credentials at Google and using this we can then invoke the `signInWithCredential` method of Firebase Auth to sign the Google User in.
```dart
  Future<String?> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        emit(SignInSuccess());
        return null;
      } catch (e) {
        return e.toString();
      }
    }
  }
```
In sign-out, we must sign out **both** from Firebase **and** Google:
```dart
    child: FilledButton(
        onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
        },
        child: Text("Sign Out")))),
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



