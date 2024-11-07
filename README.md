# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)

## Lecture 14 - FutureBuilder, StreamBuilder, Shimmer
In this lecture we will look at asynchronous data and methods to display them in the UI.

### Future Builder

We implement `FutureBuilder` widget to build result of an asynchronous operation. To test this, we build the `FutureBuilderPage` in [future_builder_page.dart](/lib/pages/future_builder_page.dart). 

### The Future

We first define a function that generates a list of `User` objects in the future. To accomplish that we simply add a delay:
```dart
Future<List<User>> getData() async {
  await Future.delayed(Duration(seconds: 3));
  List<User> users;
  users = List.generate(20, (index) {
    return User.createMockUser();
  });
  return users;
}
```
This function will generate a list of `User` objects with a 3 second delay. When we call this function this will be our `Future` of type `List<User>`.

### The FutureBuilder

This widget takes a `Future` as an argument it's builder than receives an update on the future via the `AsyncSnapshot` `snapshot` of type `<List<User>>`. We build two different widgets depending on whether the the `snapshot`'s `.hasData` property is `true` or `false`.

If the `snapshot` contains data, then we understand the `Future` has resolved. If not, it is still working. Hence we show a `CircularProgressIndicator` until the `Future` resolves. Then we access the `data` property of the `snapshot` via `snapshot.data` (which is of type `<List<User>>`) and we display the `User` objects in a `Column`.
```dart
    body: SingleChildScrollView(
    child: FutureBuilder(
        future: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.data!.map((user) {
                return UserListTile(user: user);
                }).toList(),
            );
            } else {
            return Container(
                width: double.infinity,
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Text("Fetching data"),
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                ],
                ),
            );
            }
        }),
    ),
```



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

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



