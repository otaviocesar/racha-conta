import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/models/user.dart';
import 'package:rachaconta/providers/users.dart';
import 'package:rachaconta/widgets/user_tile.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
