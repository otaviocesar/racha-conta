import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/views/user_list.dart';
import 'package:rachaconta/providers/users.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  final _total = TextEditingController();
  final _nome = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    users.limparUserTeste();
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

  _form(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validarValor(s!, field),
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white70,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white70,
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

  _botaoCalcular(_qtdPessoas) {
    return SizedBox(
      height: 40,
      width: 1500,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _calcular(_qtdPessoas);
          }
        },
        child: const Text("Calcular"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[800],
        ),
      ),
    );
  }

  _botaoLimpar() {
    return SizedBox(
      height: 40,
      width: 1500,
      child: ElevatedButton(
        onPressed: () {
          _limpar();
        },
        child: const Text("Limpar"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[800],
        ),
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
