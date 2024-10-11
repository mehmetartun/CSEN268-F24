import 'package:flutter/material.dart';

import '../model/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        '${user.firstName[0]}${user.lastName[0]}',
      ),
    );
  }
}
