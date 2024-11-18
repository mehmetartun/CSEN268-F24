import 'package:flutter/material.dart';

import '../model/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    String initials = "";
    if (user.firstName.isNotEmpty) {
      initials += user.firstName[0].toUpperCase();
    }
    if (user.lastName.isNotEmpty) {
      initials += user.lastName[0].toUpperCase();
    }
    if (initials == "") {
      initials = "-";
    }

    return CircleAvatar(
      child: Text(
        initials,
      ),
    );
  }
}
