import 'package:flutter/material.dart';
import 'package:rachaconta/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    const avatar = CircleAvatar(
      child: Icon(Icons.person),
    );
    return ListTile(
        leading: avatar,
        title: Text(user.name),
        subtitle: Text(user.valor),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.quiz),
                  color: Colors.greenAccent,
                  onPressed: () {}),
            ])));
  }
}
