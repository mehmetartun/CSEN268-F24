# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 15 - Cloud Functions and Serverless Computing
We explore Cloud Functions in Firebase using NodeJS.

### Step 6 - Firebase Storage
In this step we implement Firebase Storage. This also requires the Blaze plan to implement. There have been some changes to the naming convention of the default storage path and we shall explicitly specify the bucket. See more here: [Storage Docs](https://firebase.google.com/docs/storage/flutter/start).

First add Firebase Storage to your project
```zsh
flutter pub add firebase_storage
```
The reference to the `storage` is
```dart
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: "gs://<your-project-id>.firebasestorage.app");
```

#### Upload testing page
1. Create a `User` object in Firestore
2. Pick an image from the Gallery (or Camera)
3. Upload the image to Firebase Storage using a `storagePath` of the form `users/{userId}/images/{imageName}`. Note that with exactly this pattern we can listen to changes in Firebase Storage and take action like processing the image, creating thumbnails etc.
4. Get a `downloadUrl` for this object that enables public Url to the object which can be revoked any time by you
5. Display the image using this `downloadUrl`
6. Implement an upload progress indicator
7. Update the user object with the information about the image we uploaded in an `images` collection residing under the `user` where we store the `downloadUrl` and the `storagePath`

#### Creating User
Simple function to add a user
```dart
  void addUser() async {
    _docRef = await FirebaseFirestore.instance
        .collection('users_test')
        .add({'name': 'John Doe', 'email': 'john@doe.com'});
    setState(() {});
  }
```
#### Picking an Image
Remember to add the provisioning in [Info.plist](/ios/Runner/Info.plist):
```xml
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Access to the photo libray is needed.</string>
	<key>NSCameraUsageDescription</key>
	<string>Access to the camera is needed.</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Access to the microphone is needed.</string>
```
the Image picker is implemented as:
```dart
  void pickImage() async {
    _xfile = await _picker.pickImage(source: ImageSource.gallery);
    _imagePath = _xfile?.path;
    setState(() {});
  }
```

#### Uploading an image
To upload the image we first need to create a reference in `storage` object we defined earlier. For that we define the `storagePath`:
```dart
    String imageName =
        "${p.basenameWithoutExtension(_imagePath!)}_"
        "${DateTime.now().microsecondsSinceEpoch}."
        "${p.extension(_imagePath!)}";
    _storagePath = "users/${_docRef?.id}/images/$imageName";
```
For added security we inject the timestamp in the image name to avoid overwrites. 

As we implemented different methods for **Web** and **Android/iOS** for saving image to gallery or desktop, we need to do the same here. We already have the `SaveImage` class. We add another static method:
```dart
  static Future<String?> uploadImageToStorage(
      {required XFile file,
      required Reference storageReference,
      void Function(double)? updateCallback}) async {
        ...
        return downloadUrl;
        ...
  }
```
which returns a `downloadUrl`. This function is called as:
```dart
    _downloadUrl = await SaveImage.uploadImageToStorage(
    file: _xfile!,
    storageReference: storage.ref(_storagePath),
    updateCallback: progressCallback,
    );
```
#### The image upload details
The full image upload method is:
```dart
  static Future<String?> uploadImageToStorage(
      {required XFile file,
      required Reference storageReference,
      void Function(double)? updateCallback}) async {
    await storageReference.putFile(File(file.path));
    UploadTask task = storageReference.putFile(File(file.path));
    if (updateCallback != null) {
      task.snapshotEvents.listen((event) {
        double progress = event.bytesTransferred / event.totalBytes;
        updateCallback(progress);
      });
    }

    TaskSnapshot snapshot = await task;
    if (snapshot.state == TaskState.success) {
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return null;
    }
  }
```
The first part is creating an `UploadTask` which in itself is a future
```dart
UploadTask task = storageReference.putFile(File(file.path));
```
Then we create a listenable to be able to process progress:
```dart
if (updateCallback != null) {
    task.snapshotEvents.listen((event) {
    double progress = event.bytesTransferred / event.totalBytes;
    updateCallback(progress);
    });
}
```
Here we compare the amount of bytes transferred to the total in order to get a progress number between 0 and 1. Then we submit this number into the `updateCallback` that has been provided. We'll understand how that works a few sections below.

Then we await for the task to finish and get a snapshot, basically the final status of the upload:
```dart
TaskSnapshot snapshot = await task;
```
Depending on the status we can now proceed to get the `downloadUrl` for this file. The `downloadUrl` can be used publicly to access the image but revoked if wanted.
```dart
if (snapshot.state == TaskState.success) {
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
} else {
    return null;
}
```

#### Resulting behaviour
The complete behaviour is seen in this recording:

![Storage Demo](/assets/images/StorageUploadDemo.gif)

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



