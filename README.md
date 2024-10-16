## Santa Clara University - CSEN268 Fall 2024

### Lecture 7 Extra Material - 15 Oct 2024

This version includes what has been done in the lecture:

- Created a **Repository** abstract class with two implementations
- Injected the repository above the **MaterialApp**
- Created a stateful widget with a form to access the **signIn** method of the repository
- We also did an impelementation with a **cubit** where the repository was injected 
into the cubit at the time of the creation of the cubit. The various states of the login process was captured by 
different views which where managed by the **BlocBuilder**.

The extra material:

- Created a **Bloc** version of the same under the **SignInPage**
- Created a **HomePage** to be able to provide buttons to switch to the three different implementations
- Added routes to the **MaterialApp** to be able to navigate to the three different implementations

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



