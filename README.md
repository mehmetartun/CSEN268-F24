# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 14 - FutureBuilder, StreamBuilder, Shimmer
In this lecture we will look at asynchronous data and methods to display them in the UI. 

### Step 3 - Implement Shimmer
In the previous step we implemented the `StreamBuilder` to bring the content from the database. Shimmer allows you to display placeholders to prepare the user about the type of data the page is going to receive rather than showing a generic spinner.

#### Add shimmer package
We start by adding the package
```zsh
flutter pub add shimmer
```
#### Building a widget with Shimmer
In our case we will build 10 boxes with rounded corner as placeholders for the `'cities'` collection that will be returned. For shimmer to be effective visually:
- The width of the shimmer object shall match the width of the expected content when it arrives
- Similarly, height should roughly match as well.
- For the number of lines, you can take 5-10 placeholders  to indicate we are expecting a list. The actual list could be 100 items...

```dart
class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          children: List.generate(10, (index) {
            return Container(
              height: 15,
              width: 200,
              margin: EdgeInsets.all(3),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                  color: Colors.white),
            );
          }),
        ));
  }
}
```
#### Using the ShimmerListWidget

We inject the widget in the `StreamBuilder`:
```dart
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        builder: (context, snapshot) {
        if (snapshot.hasData) {
            ...
        }
        return ShimmerListWidget();
        },
        stream:...,
    ),
```

Finally, we will see the following when the `stream` is loading:

![Shimmer Demo](/assets/images/ShimmerDemo.gif)


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

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



