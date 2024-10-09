import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:uuid/v4.dart';
import 'dart:math' as math;

import '../model/user.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> colors = [
      "green",
      "red",
      "orange",
      "yellow",
      "blue",
      "pink",
      "cyan",
      "magenta",
      "coral",
      "brown"
    ];
    List<User> userList = List.generate(20, (index) {
      return User(
          firstName: lorem(paragraphs: 1, words: 1),
          lastName: lorem(paragraphs: 1, words: 1),
          email:
              "${lorem(paragraphs: 1, words: 1)}@${lorem(paragraphs: 1, words: 1)}.com",
          uid: UuidV4().generate(),
          imageUrl:
              'https://placehold.co/600x400/${colors[math.Random().nextInt(10)]}/${colors[math.Random().nextInt(10)]}.png');
    });

    print(userList);
    return Scaffold(
      body: Container(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("User List"),
      ),
    );
  }
}
