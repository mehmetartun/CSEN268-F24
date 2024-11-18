# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 17 - Testing
In this lecture we will explore testing of widgets and the app in general

### Step 03 - Fixing an Error in a Complex Widget Test
In the previous step we saw that the following test failed:
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
because the **last name** was empty string.

To fix this we implement the following in the `UserAvatar` in [user_avatar.dart](/lib/widgets/user_avatar.dart):
```dart
  Widget build(BuildContext context) {
    String initials = "";
    if (user.firstName.isNotEmpty) {
      initials += user.firstName[0].toUpperCase();
    }
    if (user.lastName.isNotEmpty) {
      initials += user.lastName[0].toUpperCase();
    }
    if (initials == "") {
      initials = "-";
    }

    return CircleAvatar(
      child: Text(
        initials,
      ),
    );
  }
```
When we now try running our test we get an error again:
```zsh
This was caught by the test expectation on the following line:
  file:///Users/mehmetartun/Development/csen268/CSEN268-F24/test/widget_test.dart line 45
The test description was:
  UserListTile Widget Test
════════════════════════════════════════════════════════════════════════════════════════════════════
00:01 +0 -1: UserListTile Widget Test [E]                                                                         
  Test failed. See exception logs above.
  The test description was: UserListTile Widget Test
  

To run this test again: /Users/mehmetartun/Utilities/flutter/bin/cache/dart-sdk/bin/dart test /Users/mehmetartun/Development/csen268/CSEN268-F24/test/widget_test.dart -p vm --plain-name 'UserListTile Widget Test'
00:01 +0 -1: Some tests failed.    
```
This time it's not matching the expectation `"John"` as the display name. That's because there is a `space` character that gets printed in:
```dart
    return ListTile(
      leading: UserAvatar(user: user),
      // The style of the text will be taken from the ListTileTheme
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
    );
```
We can cover this case by modifying the definition of the `UserListTile` [user_list_tile.dart](/lib/widgets/user_list_tile.dart):
```dart
  Widget build(BuildContext context) {
    String displayName = '${user.firstName} ${user.lastName}';
    displayName = displayName.trim();
    if (displayName.isEmpty) {
      displayName = "-";
    }
    return ListTile(
      leading: UserAvatar(user: user),
      title: Text(displayName),
      subtitle: Text(user.email),
    );
  }
```
This means we can now write test cases for the following cases:


| firstName | lastName | initials  | displayName |
| :-:|:-:|:-:|:-:|
| input | input | expect | expect |
|  `"John"` | `"Doe"` | `"JD"` | `"John Doe"` |
|  `"John"` | `""` | `"J"` | `"John"` |
|  `""` | `"Doe"` | `"D"` | `"Doe"` |
|  `""` | `""` | `"-"` | `"-"` |

We now have a complete test coverage:
```dart
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
    await tester.pumpWidget(createWidget(
      UserListTile(
          user: User(
        firstName: "",
        lastName: "Doe",
        email: "john@doe.com",
        imageUrl: "https://placehold.co/500x500",
        uid: "1234567890",
      )),
    ));
    expect(find.text('Doe'), findsOneWidget);
    expect(find.text('D'), findsOneWidget);
    expect(find.text('john@doe.com'), findsOneWidget);
    await tester.pumpWidget(createWidget(
      UserListTile(
          user: User(
        firstName: "",
        lastName: "",
        email: "john@doe.com",
        imageUrl: "https://placehold.co/500x500",
        uid: "1234567890",
      )),
    ));
    expect(find.text('-'), findsExactly(2));
    expect(find.text('john@doe.com'), findsOneWidget);
```
Where we used `findsExactly(2)` which means that both in the avatar and in the 
displayName we will get a `-` that means we need to get exactly two of these to pass the test.



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



