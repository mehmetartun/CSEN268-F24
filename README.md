# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Step 3 - Implement Sign Up with Email and connect to Firebase Auth

![Step 3](/assets/images/AuthStep3.png)

The email signUp view will be identical to the email signIn view initially. We can implement with just a single password field (without checking the password). The user can always reset the password in the future if they keyed in wrongly.

With this, our `switch` in the `BlocBuilder` becomes:
```dart
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          switch (state) {
            case SignUpState _:
              return SignUpView(emailSignUpCallback: cubit.emailSignUp);
            case SignInInitial _:
            default:
              return SignInView(emailSignInCallback: cubit.emailSignIn);
          }
        },
      ),
```

### Calling Firebase Auth
We can now implement the two methods `emailSignIn` and `emailSignUp`.
```dart
  Future<String?> emailSignIn(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SignInSuccess());

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.code;
      }
    } catch (e) {
      return e.toString();
    }
  }
```
The implementation of the Sign Up process is similar. The mechanics is such that on success, we emit a state which gets caught by the `BlocListener`. We modifed our `BlocBuilder` to a `BlocConsumer` such that the listener can trigger a route change. Now the listener asks the route to change to `home`.

On the other hand if there is an error it gets return to the Sign Up or Sign In page and displayed to the user while the controllers are being cleared. This is  in the `onPressed` method of the button
```dart
  child: FilledButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          _formKey.currentState?.save();
          errorMessage = await widget.emailSignInCallback(
              email: email!, password: password!);
          if (errorMessage != null) {
            setState(() {
              emailController.clear();
              passwordController.clear();
              crossFadeState = CrossFadeState.showSecond;
            });
          }
        }
      },
      child: Text("Sign In")),
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



