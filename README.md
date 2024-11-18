# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 17 - Testing
In this lecture we will explore testing of widgets and the app in general

### Step 05 - Testing Tap
In this case we try to tap in our user list. We first create a tap behaviour on our widget by modifying `ListTile` in our `UserListTile`.
```dart
    return ListTile(
      leading: UserAvatar(user: user),
      title: Text(displayName),
      subtitle: Text(user.email),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$displayName added.")),
        );
      },
    );
```
Now we `fling` our `ListView` back up and find the first `UserListTile`. This would correspond to user `First0 Last0`. 
```dart
    await tester.fling(find.byType(ListView), Offset(0, 200), 400);
    await tester.pumpAndSettle();
    expect(find.text("First0 Last0"), findsOne);
    await tester.tap(find.byType(UserListTile).first);
    await tester.pumpAndSettle();
    expect(find.text('First0 Last0 added.'), findsOne);
```
In the above we should have `First0 Last0 added.` displayed in the `SnackBar`.

![TapTesting](/assets/images/Testing%20Tap%20Behaviour.gif)

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



