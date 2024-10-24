## Santa Clara University - CSEN268 Fall 2024

### Lecture 7 - 15 Oct 2024

#### Repository Pattern and Repository Provider

During this lecture first create the **AuthenticationRepository** which has an `abstract class`
that prescribes a `signIn` method. 

```dart
abstract class AuthenticationRepository {
  Future<User> signIn({
    required String email,
    required String password,
  });
}
```
The specific implementation will be an extension of this abstract class
```dart
class FirebaseAuthenticationRepository extends AuthenticationRepository {
  Future<void> someFirebaseSpecificMethod() async {
    ...
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    await someFirebaseSpecificMethod();
    return User.createMockUser();
  }
}
```

We can then inject the desired repository into our Widget tree as
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
        ...
      ),
    );
  }
}
```

#### Implement the Repository Pattern in a Stateful Widget

Here we create a Stateful Widget which has two formfields for **email** and **password**. The Authentication Repository mocks the `signIn` by returning a mock `User`. The `signIn` method is **asynchronous** such that the result doesn't come immediately. The widget is implemented in `stateful_login_page.dart`.

1. In the `initState()` of the widget we create a handle to the `AuthenticationRepository` via:
    ```dart
      @override
      void initState() {
        repo = RepositoryProvider.of<AuthenticationRepository>(context);
        super.initState();
      }
    ```
2. The `Form` is a stateful widget and by accessing it's key via a `GlobalKey` we can access it's current state and manipulate the `Form` such as validating and saving values. 
```dart
final _formKey = GlobalKey<FormState>();
```
3. The asynchronous `loginUser` function does a few things:
    - It refreshes the screen with `busy` set to `true` and the button on the `Form` is no longer clickable.
    - Then the `signIn` method of the repository is `await`ed.
    - The result is placed in the `user` variable and the screen is refreshed again.
    - If the `user` is not null, we do an **unawaited** call to `showSnackBar()` which displays a snackbar on the bottom
    of the screen with the user information.
4. Looking at the `Form` we can see a few things:
    - The `TextFormField` has two functions that are for validation and saving.
      ```dart
      TextFormField(
        decoration: const InputDecoration(
          labelText: "Password",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onSaved: (value) {
          password = value;
        },
        readOnly: busy ? true : false,
      ),
      ```
      where the `validator` takes the current `value` of the `TextFormField` and checks against validation rules. If valid, it returns `null`. If not, it returns a `String` containing the error message which then gets displayed by the `TextFormField` widget which itself is a stateful widget. With the `onSaved` function, the `TextFormField` passes it's current value to the function and in this case the function simply saves this value to the `email` and `password` variables.
    - The `submit` button at the end of the `Form` will first validate the form and then if it returns `true` then it goes on to saving which then triggers the `onSaved` function of each individual form element.
      ```dart
      if (_formKey.currentState?.validate() ?? false) {
            _formKey.currentState?.save();
            loginUser();
          }
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



