## Santa Clara University - CSEN268 Fall 2024

### Lecture 6 - 10 Oct 2024

#### Fix Flutter Lorem issue

In the previous lecture we installed the `flutter_lorem` package to create 
random text from the famous **Lorem Ipsum**. We used this package where we 
created 1 paragraph 1 word sentences. The downside was that it created text 
with a punctuation at the end.

We need to modify the result to remove the final punctuation mark.

#### Create Mock class

The `Mock` class will be created to generate mock entities with these static methods:

    static String mockFirstName(){ }
    static String mockLastName(){ }
    static String mockEmail({String firstName,String lastName,String companyName}){ }
    static String mockUid(){}
    static String mockImageUrl({String firstName,String lastName}){}
    ....
    static String mockParagraph(){} 
    static String mockTitle(){}

Note that for `mockEmail` we include optional variables to compose the email 
to match the first name, last name, and company name of the individual. 
But if they are null, it needs to be dealt with. Similarly for `mockImageUrl` we include 
the first name and last name in case we want to create an image with the initials.

The importance of the Mock class is that we can later change the implementation of name
generation or image generation without changing the `User` class. For example we may first implement it with `flutter_lorem` but 
later we can move to a random pick from a list of first names. Same for last names etc.

#### Create a method in the User class for mock User object

We can use `static` method in the `User` class to create a `mock` User. This would be then called:

    User user = User.createMockUser();

Here the properties of this user will be created using methods in the Mock class.

#### Create widgets that display a User object

In the `widgets` folder:
- Create a widget that returns a `ListTile` displaying user's image, name, and email.
- Create a widget that returns a `Card` displaying a vertical widget with an image in the center, name, and email.
- Create a widget that returns a `CircleAvatar` displays either an image or in the absence of that display initials.

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



