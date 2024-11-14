# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Step 2 - Create SignIn Page, add Cubit and Sign In View (email)

![Step 2](/assets/images/Auth_Step2.png)

The cubit has an unimplemented function `emailSignIn` that is passed on to the `SignInView` as a callback. In the `SignInPage`, the initial state is rendered as the `SignInView:
```dart
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          switch (state) {
            case SignInInitial _:
            default:
              return SignInView(emailSignInCallback: cubit.emailSignIn);
          }
        },
      ),
```
Here the `Form` takes an email and password and passes it to the `emailSignInCallback` which is the `emailSignIn` method in the `SignInCubit`.

With this, our screen becomes:
<img src="/assets/images/AuthStep2_Screen.png" alt="Alt Text" width="300">
<!-- ![SignIn Screen](/assets/images/AuthStep2_Screen.png) -->



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



