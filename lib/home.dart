import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/views/user_list.dart';
import 'package:rachaconta/providers/users.dart';

import 'models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _total = TextEditingController();
  final _nome = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    final _qtdPessoas = users.count;
    return Scaffold(
      body: _body(_qtdPessoas, users),
    );
  }

  void _limpar() {
    _total.text = "";
    _nome.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  _body(_qtdPessoas, users) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _formName("Nome", _nome),
              _botaoCadastrar(users),
              const SizedBox(height: 15),
              _form("Valor Total", _total),
              _botaoLimpar(),
              const SizedBox(height: 15),
              _botaoCalcular(_qtdPessoas),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(height: 500, child: UserList()),
      ),
    ]);
  }

  _formName(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validarNome(s!, field),
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  _form(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validarValor(s!, field),
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  String? _validarValor(String text, String field) {
    if (text.isEmpty || int.parse(text) < 1) {
      return "$field deve ser maior que 0!";
    }
    return null;
  }

  String? _validarNome(String text, String field) {
    if (text == null || text.trim().isEmpty) {
      return "$field inválido!";
    }

    if (text.trim().length < 3) {
      return "$field muito pequeno. No mínimo 3 letras.";
    }
    return null;
  }

  _botaoCadastrar(users) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          users
              .put(User(id: "", name: _nome.text, qtdAcertos: "0", valor: "0"));
        },
        child: const Text("Incluir"),
      ),
    );
  }

  _botaoCalcular(_qtdPessoas) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _calcular(_qtdPessoas);
          }
        },
        child: const Text("Calcular"),
      ),
    );
  }

  _botaoLimpar() {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          _limpar();
        },
        child: const Text("Limpar"),
      ),
    );
  }

  void _calcular(_qtdPessoas) {
    setState(() {
      var pessoas = _qtdPessoas.toString();
      double valor = double.parse(_total.text);
      print(valor);
      print(_qtdPessoas);
      double qtpessoas = double.parse(pessoas);
      double vruni = (valor / qtpessoas);
      double total = valor;
      String vruniStr = vruni.toStringAsPrecision(4);
      String vrtotal = total.toStringAsPrecision(4);
      print("Valor Para Cada Um: $vruniStr"
          "\nValor Total da Conta: $vrtotal");
    });
  }
}
