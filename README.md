# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 17 - Testing
In this lecture we will explore testing of widgets and the app in general

### Packages
We remove all the packages from the previous lecture and leave only:
```yaml
  flutter_lorem: ^2.0.0
  uuid: ^4.5.1
  flutter_bloc: ^8.1.6
  go_router: ^14.3.0
  firebase_core: ^3.6.0
  intl: ^0.19.0
  cloud_firestore: ^5.4.4
```
and add the following:
```zsh
flutter pub add dev:test 'dev:flutter_driver:{"sdk":"flutter"}' 'dev:integration_test:{"sdk":"flutter"}'
```
with `dev_dependency` meaning it's a development dependency included in **devopment** mode. They are not included in the **release** mode,.

### Basic Test of the App
A basic test is shown in the [widget_test.dart](/test/widget_test.dart). To run this test we can either:
```zsh
flutter test test/widget_test.dart
```
or
```zsh
flutter run test/widget_test.dart
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



