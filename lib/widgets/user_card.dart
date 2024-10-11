import 'package:flutter/material.dart';

import '../model/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: Image.network(user.imageUrl).image,
              ),
            ),
            Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(user.email),
          ],
        ),
      )),
    );
  }
}
