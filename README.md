## Santa Clara University - CSEN268 Fall 2024

### Lecture 8 Part 2 - 17 October 2024

In this lecture we accomplish a number of things:
1. Nested Navigation using `ShellRoute` in `GoRouter`
2. Utilize the `refreshListenable` property of the `GoRouter` which allows the `redirect` to be run on any change that comes through the `refreshListenable`. For that purpose, we turn the `AuthenticationBloc.stream` to a **listenable**. 
3. We add a **signIn** and **signOut** buttons in the app to trigger changes in the  `AuthenticationBloc` and observe the `GoRouter` redirecting us to the `/login` route. 


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



