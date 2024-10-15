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
    List<User> userList = List.generate(20, (index) {
      return User.createMockUser();
    });

    print(userList);
    return Scaffold(
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User List"),
      ),
    );
  }
}
