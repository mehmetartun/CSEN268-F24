import 'package:CSEN268_F24/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:uuid/v4.dart';
import 'dart:math' as math;

import '../model/user.dart';
import '../widgets/user_card.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // const List<String> colors = [
    //   "green",
    //   "red",
    //   "orange",
    //   "yellow",
    //   "blue",
    //   "pink",
    //   "cyan",
    //   "magenta",
    //   "coral",
    //   "brown"
    // ];
    // List<User> userList = List.generate(20, (index) {
    //   return User(
    //       firstName: lorem(paragraphs: 1, words: 1),
    //       lastName: lorem(paragraphs: 1, words: 1),
    //       email:
    //           "${lorem(paragraphs: 1, words: 1)}@${lorem(paragraphs: 1, words: 1)}.com",
    //       uid: const UuidV4().generate(),
    //       imageUrl:
    //           'https://placehold.co/600x400/${colors[math.Random().nextInt(10)]}/${colors[math.Random().nextInt(10)]}.png');
    // });

    List<User> userList = List.generate(20, (index) {
      return User.createMockUser();
    });

    print(userList);
    return Scaffold(
      //body: UserCard(user: userList[0]),
      // body: UserListTile(user: userList[0]),
      // body: ListView(
      //     children: userList.map((user) {
      //   return UserListTile(user: user);
      // }).toList()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                    child: UserCard(user: userList[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: userList.length,
              ),
            ),
            Container(
              height: 700,
              child: ListView.separated(
                // scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return UserListTile(user: userList[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: userList.length,
              ),
            ),
            Container(height: 300, color: Colors.red, width: double.infinity),
          ],
        ),
      ),
      //Text("Hello World"),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 300,
      //       child: ListView.separated(
      //         primary: false,
      //         itemBuilder: (context, index) {
      //           return UserListTile(user: userList[index]);
      //         },
      //         separatorBuilder: (context, index) {
      //           return const Divider();
      //         },
      //         itemCount: userList.length,
      //       ),
      //     ),
      //     Divider(
      //       color: Theme.of(context).colorScheme.primary,
      //       height: 2,
      //       thickness: 2,
      //     ),
      //     const SizedBox(height: 20),
      //     Container(
      //       height: 300,
      //       child: ListView.separated(
      //         scrollDirection: Axis.horizontal,
      //         primary: false,
      //         itemBuilder: (context, index) {
      //           return Padding(
      //             padding: index == 0
      //                 ? const EdgeInsets.only(left: 20)
      //                 : EdgeInsets.zero,
      //             child: UserCard(user: userList[index]),
      //           );
      //         },
      //         separatorBuilder: (context, index) {
      //           return const SizedBox(width: 10);
      //         },
      //         itemCount: userList.length,
      //       ),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User List"),
      ),
    );
  }
}
