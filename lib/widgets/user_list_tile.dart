import 'package:flutter/material.dart';

import '../model/user.dart';
import 'user_avatar.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(user: user),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
    );
  }
}
