## Santa Clara University - CSEN268 Fall 2024

### Lecture 8 - Part 1 - Basic Go Router Implemented

In the first part of the lecture we implemented a basic `GoRouter`. For this we need a different constructor for the `MaterialApp`, namely `MaterialApp.router`
```dart
    child: MaterialApp.router(
    title: 'Flutter Demo',
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
    ),
    routerConfig: router,
    ),
```
Here the `router` is a `GoRouter` object which we shall investigate below:
```dart
class RouteName {
  static const home = "home";
  static const bloc = "bloc";
  static const cubit = "cubit";
  static const noBloc = "noBloc";
}
final router = GoRouter(routes: [
  GoRoute(
      name: RouteName.home,
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
            name: RouteName.bloc,
            path: 'bloc',
            builder: (context, state) {
              return const SignInPage();
            }),
        GoRoute(
            name: RouteName.cubit,
            path: 'cubit',
            builder: (context, state) {
              return const LoginPage();
            }),
        GoRoute(
            name: RouteName.noBloc,
            path: 'noBloc',
            builder: (context, state) {
              return const StatefulLoginPage();
            }),
      ]),
]);
```
1. The `router` definition assigns a `name` and `path` to each route which is a `GoRoute`. 
2. Each `GoRoute` has a `builder` and that takes `state` of type `GoRouterState` and `context`. 
3. The child routes of a `GoRoute` imply they will be **pushed** on top of the parent. Any siblings of a `GoRoute` imply they will be **replaced**. Under the hood it's `Navigator.pushNamed()` and `Navigator.pushReplacementNamed()`
4. Optionally `GoRouter` as well as `GoRoute` objects can have `redirect`, `errorBuilder`, etc to be explored later.
5. In order not to pass text around, we created a class `RouteName` and assigned static properties that means we won't be using arbitrary strings within our code and avoid errors.

#### Navigation with the GoRouter
In the `HomePage()` the buttons have the navigation methods attached:
```dart 
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: SingleChildScrollView(
            ...
            FilledButton(
                child: const Text("Login - no Bloc/Cubit"),
                onPressed: () {
                context.goNamed(RouteName.noBloc);
                },
            ),
            ...
```
Either `context.goNamed()` or `GoRouter.of(context).goNamed()` can be used.

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



