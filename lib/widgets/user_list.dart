import 'package:flutter/material.dart';
import 'package:rachaconta/data/users_data.dart';
import 'package:rachaconta/widgets/user_tile.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = usersList;
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i) => UserTile(users.values.elementAt(i)),
      ),
    );
  }
}
