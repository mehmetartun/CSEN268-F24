import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
        actions: [
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: () {
              controller.animateTo(0, curve: Curves.bounceIn);
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              controller.forward();
            },
          )
        ],
      ),
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
