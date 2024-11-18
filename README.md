# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 17 - Testing
In this lecture we will explore testing of widgets and the app in general

### Step 04 - Testing Scrolling
In this case we shall build a user list and ensure that we have a list that we can scroll and tap.

To do this we start by creating a page with a `ListView` and create 10 mock users. In our [widget_test.dart](/test/widget_test.dart) file we first create a `ListView`:
```dart
  Widget createUserList() {
    return ListView(
        children: List.generate(20, (index) {
      return UserListTile(
          user: User(
              firstName: "First$index",
              lastName: "Last$index",
              imageUrl: "https://placehold.co/400x400",
              email: "first$index@last$index.com",
              uid: "$index"));
    }));
  }
```
which then gets injected into `createWidget` as child. The call to the tester is to expect a `ListView`. 

#### Checking ListView and the first item
```dart
    expect(find.byType(ListView), findsOne);
```
will pass. 

Similary checking if "First0 Last0" exists – corresponding to the first user on the list – will be done:
```dart
    expect(find.text("First0 Last0"), findsOne);
```
We can see that both these will pass.

#### Checking the Scroll Behaviour
To check the scroll behaviour we use  `tester.fling()` method. 
```dart
    ...
    await tester.fling(find.byType(ListView), Offset(0, -200), 400);
    await tester.pumpAndSettle();
    expect(find.text("First0 Last0"), findsNothing);
    ...
```
This means that we would scroll past the first item in the list and we would not find any text that matches this. Note that the origin on the screen is the upper left hand corner and an offset of (0,-200) means scroll down by 200 pixels. This passes as well.

Using `flutter run` instead of `flutter test` we can see this playing out on the simulator as seen in this video:

![Scroll Test](/assets/images/Testing%20Scroll%20Behaviour.gif)

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



