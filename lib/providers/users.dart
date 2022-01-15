import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:rachaconta/data/users_data.dart';
import 'package:rachaconta/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> users = usersList;

  Iterable<User> get all {
    return users.values;
  }

  int get count {
    return users.length;
  }

  User byIndex(int i) {
    return users.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    //adicionar
    final id = Random().nextDouble().toString();
    users.putIfAbsent(
        id,
        () => User(
            id: id,
            name: user.name,
            qtdAcertos: user.qtdAcertos,
            valor: user.valor));

    notifyListeners();
  }
}
