# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)

## Lecture 13 - Starting point for Explicit Animations

For doing explicit animation we add the `SingleTickerStateProviderMixin` to the `State` of the Stateful Widget in the [animation_page.dart](/lib/pages/animation_page.dart)
```dart
class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  ...
}
```
here we define an `AnimationController` which drives the animation and a listenable called `Animation` of type `double`. The value of this listenable will be changed by the `AnimationController`.

In the `initState()` we initialize the `animation` and `controller`:
```dart
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    animation = Tween<double>(begin: 0, end: 200).animate(controller)
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
Here the `AnimationController` needs a ticker which now comes through `vsync: this` as we have included the `SingleTickerStateProviderMixin`. The `animation` itself is a `Tween<double>` which interpolates between a starting and ending value depending on the curreng value of the controller.

The `addListener()` gets triggered everytime the animation gets advanced and with `setState()` we ensure that the widget is rendered again with the new `animation.value`. The logic is such that the `controller` has a certain `Duration`. In this case, 3000 milliseconds. That means at a frame rate of say 30 frames per second for rendering the screen, the `setState()` would be called approximately every 30 milliseconds, corresponding to say 100 times in total. 

In addition, `addStatusListener()` listen to status changes of the controller, such as `AnimationStatus.completed` where we can stop the animation. We attach a snackbar to the status change to see the values coming in. We also add  the values of the `controller` and `animation` to see how they are changing.

To show the relative change of the `Container` from original state we use a `Stack` widget. At the bottom is a grey `Container` that indicates the base state and above it is our animating `Container` with the variable value that gets re-rendered at every `setState()`. Therefore the `body` of our `Scaffold` is:
```dart
    body: Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("The forward animation will be linear as"
              " we use simpy controller.forward()."),
          SizedBox(height: 10),
          Text("The reset animation uses a curve to animate"
              " the controller back to zero."),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 200, height: 200, color: Colors.grey[300]),
              Container(
                color: Colors.red,
                width: animation.value,
                height: animation.value,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
              "Controller: ${NumberFormat("0.00").format(controller.value)}"),
          SizedBox(height: 10),
          Text("Animation: ${NumberFormat("0.00").format(animation.value)}")
        ],
      ),
    )),
```
The resulting behavior is:
![Animation](/assets/images/AnimationDemoGif.gif)

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



