## Santa Clara University - CSEN268 Fall 2024

### Lecture 5 - 8 Oct 2024

In this lecture we will look at layout elements but to be able to do that we need widgets to fill the screen and using various packages we will create random objects. 

#### Lorem package

For this we will utilize a package called `flutter_lorem` to generate placeholder text in our application while we are preparing the UI. In your terminal at the root directory of your project do the following to add the package to your project:

    flutter pub add flutter_lorem

#### Math library

We will also utilize random integers from `dart:math` library. To import the library the customary command is:

    import 'dart:math' as math;

To generate a random integer between 0 (including) and 10 (excluding) the command is:

    int i = math.Random().nextInt(10)

#### Placeholder Images

We will also need placeholder images. This is available at [Placehold](https://placehold.co/) with a number of options. We can use it in the following manner:

    String imagePath = 'https://placehold.co/600x400/orange/white.png'

#### List of color names

Where we will have a **List** of colors matching **CSS** colors and we will randomly pick a number and pick the color name from the **List** of 10 colors. Create a list with the following colors and save them in `constants.dart` file:

    green, red, orange, yellow, blue, pink, cyan, magenta, coral, brown

#### Unique ID generator

We use the `uuid` package. To install

    flutter pub add 

To use we can use the `v4` by calling

    String id = UuidV4().generate();

## User Class

Create a **User** class with the following properties:

    String firstName
    String lastName
    String uid
    String email
    String imageUrl

Use the **Data Class Generator** extension in VSCode to add methods to the `User` class

Crate a `List` of `User` objects where you create the object as

    User user = User(
        firstName: <From lorem package, 1 paragraph, 1 word>,
        lastName: <similar to above>,
        email:  <Construct random email from 1 word lorems>, 
        imageUrl: 'https://placehold.co/600x400/<randomColor>/<randomColor>.png', 
        uid: <From uuid package>
    );

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



