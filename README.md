## Santa Clara University - CSEN268 Fall 2024

### Lecture 7 - 15 Oct 2024 - Part 2

We look at the repository pattern and continue to bloc library. Use the following to add the bloc_library to your code.

    flutter pub add flutter_bloc

#### RepositoryProvider

The tag `L07.01` will already include the `RepositoryProvider` implemented for the `AuthenticationRepository`.

#### Cubit

In this version we implement the `Cubit` pattern to handle the state changes with authentication. Under `pages` directory we create a directory for our `LoginPage`:
```md
login
├── cubit
│   ├── login_cubit.dart
│   └── login_state.dart
├── login_page.dart
└── views
    ├── error_view.dart
    ├── initial_view.dart
    ├── logged_in_view.dart
    └── waiting_view.dart
```
The structure is such that the entry point is the `LoginPage()` which creates the `LoginCubit` and then depending on the `LoginState` it displays different views. Looking closely at `LoginPage` (in <login_page.dart>):
```dart filename="login_page.dart"
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          RepositoryProvider.of<AuthenticationRepository>(context))
        ..init(), //We are passing the AuthenticationRepository into the cubit
      // Remember: Cubit doesn't have access to the context! Without access to
      // the context it cannot reach the repository through RepositoryProvider.of<>
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state) {
            case LoginError _:
              return ErrorView(errorText: (state as LoginError).errorText);
            case LoginWaiting _:
              return WaitingView();
            case LoggedIn _:
              return LoggedInView();

            case LoginInitial _:
            default:
              return InitialView();
          }
        },
      ),
    );
  }
}
```
We see that:
1. The widget itself is a **stateless** widget. The state changes are handled by the `BlocBuilder`.
2. The `LoginCubit` is created with the repository injected in it through the `RepositoryProvider.of` construct.
3. The `BlocBuilder` uses a `switch` to display different views based on the state.
4. Whenever the `LoginCubit` is created, the `init()` method is called via the `..init()` syntax. Typically your cubit will issue an
**initial** state upon creation. Then the `init()` can run asynchronously to determine the starting state and emit that state. Meanwhile, the **initial** state would be built by the `BlocBuilder` and could display a **waiting** indicator until the cubit determines it's state.

Examining the `LoginCubit` we see a few methods defined by the cubit.
```dart filename="login_cubit.dart"
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitial());
  User? user;
  final AuthenticationRepository authenticationRepository;
  void init() async {}
  void reset() {
    user == null;
    emit(LoginInitial());
  }
  void error() {
    emit(LoginError(errorText: "Some unknown error."));
  }
  void loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginWaiting());
    user =
        await authenticationRepository.signIn(email: email, password: password);
    emit(LoggedIn());
  }
}
```
1. The `init()` method is empty here but is good to keep as a pattern
2. The other methods are self explanatory and they `emit` corresponding states.
3. In the case of `loginUser()` we first emit `LoginWaiting()` which should be change the display to a **waiting** view. Then, when the
result of the `signIn()` method comes back from the `AuthenticationRepository`, the actual `LoggedIn()` state is emitted.

#### The behavior of the Login Page

![Login Page](/assets/images/login_cubit_demo.gif)

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



