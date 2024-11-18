import 'package:flutter/material.dart';

import '../model/user.dart';
import 'user_avatar.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    String displayName = '${user.firstName} ${user.lastName}';
    displayName = displayName.trim();
    if (displayName.isEmpty) {
      displayName = "-";
    }
    return ListTile(
      leading: UserAvatar(user: user),
      title: Text(displayName),
      subtitle: Text(user.email),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Display Name"),
        ));
      },
    );
  }
}
