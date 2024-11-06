# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)

## Lecture 13 - Starting point for Explicit Animations

We will now modify the `color` property of the `Container()`. To to this we need to define our animation as `<Color>` and create the `Tween` accordingly. In this case we use a special class to interpolate between colors, `ColorTween` which returns a type `Animation<Color?>`. Therefore we modify our `animation` variable to be of type `Animation<Color?>`. We fix the container size to 180x180.
```dart
class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    animation = ColorTween(begin: Colors.yellow[700], end: Colors.blue[400])
        .animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        switch (status) {
          default:
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(status.name)));
        }
      });
    super.initState();
  }
```

The resulting behavior is:
![Animation](/assets/images/AnimationDemo2Gif.gif)

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



