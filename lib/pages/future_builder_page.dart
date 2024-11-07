import 'package:CSEN268_F24/model/user.dart';
import 'package:CSEN268_F24/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';

Future<List<User>> getData() async {
  await Future.delayed(Duration(seconds: 3));
  List<User> users;
  users = List.generate(20, (index) {
    return User.createMockUser();
  });
  return users;
}

class FutureBuilderPage extends StatelessWidget {
  const FutureBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder Demo"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: snapshot.data!.map((user) {
                    return UserListTile(user: user);
                  }).toList(),
                );
              } else {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Fetching data"),
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
