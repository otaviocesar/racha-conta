import 'package:flutter/material.dart';
import 'package:rachaconta/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/providers/users.dart';

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
        subtitle: Text(
            "Acertos: " + user.qtdAcertos + "/ Valor a pagar: " + user.valor),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('Excluir Usuário'),
                              content: const Text('Tem certeza?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Não'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: const Text('Sim'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                ),
                              ],
                            )).then((confirmed) {
                      if (confirmed) {
                        Provider.of<Users>(context, listen: false).remove(user);
                      }
                    });
                  }),
            ])));
  }
}
