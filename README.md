# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Step 1 - Add Firebase Auth and listen to Auth 
We add Firebase Auth to our project by:
```zsh
flutter pub add firebase_auth
```
To run, you will be required to change the `minSdk` to `23` in [build.gradle](/android/app/build.gradle).

### Configuring the Router
In our [router.dart](/lib/navigation/router.dart) we make our initial configuration as follows:
```dart
final GoRouter router = GoRouter(
  refreshListenable:
      StreamToListenable([FirebaseAuth.instance.authStateChanges()]),
  redirect: (context, state) {
    if (FirebaseAuth.instance.currentUser == null &&
        !(state.fullPath?.startsWith("/sign_in") ?? false)) {
      return "/sign_in";
    }
    return null;
  },
  initialLocation: "/",
  routes: [
    GoRoute(
      path: MyRoutes.home.path,
      name: MyRoutes.home.name,
      builder: (context, state) => GenericPage(title: "Home"),
    ),
    GoRoute(
      path: MyRoutes.signIn.path,
      name: MyRoutes.signIn.name,
      builder: (context, state) => GenericPage(title: "Sign In"),
    ),
  ],
);
```
Here the `redirect` is triggered every time a new route is requested **or** the `refreshListenable` gets triggered by the stream `authStateChanges()`. If the path is not pointed to `/sign_in`, then it will be directed there in case the `currentUser` is null.
> Note that the `refreshListenable` doesn't do anything with the values in the stream, it only gets triggered.

To avoid using Strings withing the code, we create `MyRoute` and `MyRoutes` to refer to paths and route names through these classes.
```dart
class MyRoutes {
  static final signIn = MyRoute(name: "signIn", path: "/sign_in");
  static final home = MyRoute(name: "home", path: "/");
}

class MyRoute {
  final String name;
  final String path;

  MyRoute({required this.name, required this.path});
}
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



