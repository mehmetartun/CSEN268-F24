# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Step 4 - Implement Forgot Password
We add `ForgotState` and also implement a `ForgotPasswordView`.

### ForgotPasswordView

This has only one textfield, `email` which will be used to send a reset link email.  On this view the user can change their mind and switch back to `SignInView`. In the `cubit` the call that handles the password reset is:
```dart
  Future<String?> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      emit(SignInInitial());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
```
### Flowchart
Desired flow of the email authentication is:

![Flowchart](/assets/images/LoginFlowChart.png)


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



