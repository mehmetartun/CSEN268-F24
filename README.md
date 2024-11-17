# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 17 - Testing
In this lecture we will explore testing of widgets and the app in general

### Step 02 - Testing a Complex Widget
In this case let's create a complex widget and test it's behavior.

Widgets that we create standalone need a `MaterialApp` to create the widget tree:
```dart
  Widget createWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }
```
is a simple wrapper for the individual widget that we are testing.

Let's look at `UserListTile` which displays the user's display name (first name and last name combined) as well as their email and initials in the avatar.
Our test is then defined as:
```dart
  testWidgets('UserListTile Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget(
      UserListTile(
          user: User(
        firstName: "John",
        lastName: "Doe",
        email: "john@doe.com",
        imageUrl: "https://placehold.co/500x500",
        uid: "1234567890",
      )),
    ));
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('JD'), findsOneWidget);
    expect(find.text('john@doe.com'), findsOneWidget);
  });
```
and running the test we see that:
```zsh
flutter test test/widget_test.dart
00:01 +1: All tests passed!             
```

### Adding cases to your test suite
Let's add a few test cases to ensure that the widget can handle it. For that, let's pass a last name that's empty:
```dart
    await tester.pumpWidget(createWidget(
      UserListTile(
          user: User(
        firstName: "John",
        lastName: "",
        email: "john@doe.com",
        imageUrl: "https://placehold.co/500x500",
        uid: "1234567890",
      )),
    ));
    expect(find.text('John'), findsOneWidget);
    expect(find.text('J'), findsOneWidget);
    expect(find.text('john@doe.com'), findsOneWidget);
```
In this case we would expect the display name to be **John** and the initials to just show **J**. Let's run this and see what we get:
```zsh
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following message was thrown:
Multiple exceptions (4) were detected during the running of the current test, and at least one was
unexpected.
════════════════════════════════════════════════════════════════════════════════════════════════════
```
We get a few errors. When investigating the output above we note that:
```zsh
══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
The following RangeError was thrown building UserAvatar:
RangeError (index): Invalid value: Valid value range is empty: 0

The relevant error-causing widget was:
  UserAvatar
  UserAvatar:file:///Users/mehmetartun/Development/csen268/CSEN268-F24/lib/widgets/user_list_tile.dart:13:16
```
This is because our `UserAvatar` doesn't expect strings shorter than 1 for the first name and last name. From [user_avatar.dart](/lib/widgets/user_avatar.dart) we see that it references the first character:
```dart
    return CircleAvatar(
      child: Text(
        '${user.firstName[0].toUpperCase()}${user.lastName[0].toUpperCase()}',
      ),
    );
```
Now with the help of the test result we can rectify this in the next step.

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



