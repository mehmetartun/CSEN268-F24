## Santa Clara University - CSEN268 Fall 2024

### Lecture 7 - 15 Oct 2024 - Part 3 

This version follows on from the tag **L07.02** where we implemented a **cubit** for state management. In this version we will:
1. Implement the **Bloc Pattern** for state and event management
2. Implement navigation routes in the `MaterialApp` and use `Navigator.push()` and `Navigator.pop()` commands.

#### Implementing the Bloc Pattern

For the Bloc Pattern we create a new page called `SignInPage()` which resides under the `sign_in` directory under `pages`:
```md
sign_in
├── bloc
│   ├── sign_in_bloc.dart
│   ├── sign_in_event.dart
│   └── sign_in_state.dart
├── sign_in_page.dart
└── views
    ├── error_view.dart
    ├── initial_view.dart
    ├── signed_in_view.dart
    └── waiting_view.dart
```

The views are identical to the case with the `LoginPage()` which was implemented with a **cubit**. The extra information in the **Bloc** are the **events**.
```dart filename="sign_in_event.dart"
sealed class SignInEvent {}

class SignInWithEmailEvent extends SignInEvent {
  final String email;
  final String password;
  SignInWithEmailEvent({required this.email, required this.password});
}
class SignInErrorEvent extends SignInEvent {
  final String errorText;
  SignInErrorEvent({required this.errorText});
}
class SignInResetEvent extends SignInEvent {}
```
The events can carry information and they are added to the bloc by 
```dart
BlocProvider.of<SignInBloc>(context).add(SignInResetEvent());
```
In comparison to the **cubit** the **bloc** has to have **Event Handlers**.
```dart filename="sign_in_bloc.dart"
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this.authenticationRepository) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignInWithEmailEvent>((event, emit) {
      loginUser(email: event.email, password: event.password);
    });
    on<SignInErrorEvent>((event, emit) {
      error(event, emit);
    });
    on<SignInResetEvent>((event, emit) {
      reset(event, emit);
    });
  }
```
The methods of the bloc such as `reset()`, `error()`, etc. shall not be called directly and instead, they should be called only by the event handlers. If the bloc needs to do something, we add an **event** to the bloc. For the `ErrorView()` the reset button would be coded as:
```dart
FilledButton(
    child: const Text("Reset"),
    onPressed: () {
        BlocProvider.of<SignInBloc>(context).add(SignInResetEvent());
    },
)
```

#### Navigation
To do navigation we define **routes** in the `MaterialApp` together with an initial location, or **home**.
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return (OktaAuthenticationRepository() as AuthenticationRepository);
      },
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/noBloc': (context) => const StatefulLoginPage(),
            '/bloc': (context) => const SignInPage(),
            '/cubit': (context) => const LoginPage(),
          }),
    );
  }
}
```
In the above example we defined 4 routes which means when the Navigator is requested to handle these routes, the Navigator knows which widget to show. Once the route is defined, navigation can be done by simply calling `Navigator.pushNamed`. 
```dart
FilledButton(
child: const Text("Login - no Bloc/Cubit"),
onPressed: () {
    Navigator.pushNamed(context, '/noBloc');
},
),
```
The important distinction is between `pushNamed` and `pushReplacementNamed` where the former pushes a page on top of the current stack, the latter replaces the current page on the top of the stack with a new page. 
> When a page is pushed onto the stack, the default behaviour of `AppBar` is to add a **back** button which gets
>`Navigator.pop(context)` assigned to it. If this behaviour is not desired you need to turn off
>`automaticallyImplyLeading` property of the `AppBar` widget.

The behaviour of the Navigation can be seen in this video
![Navigator and Bloc](/assets/images/NavigationAndSignIn.gif)




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



