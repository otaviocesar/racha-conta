import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _total = TextEditingController();
  final _qtdPessoas = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Racha Conta com Quiz"), centerTitle: true),
      body: _body(),
    );
  }

  void _limpar() {
    _total.text = "";
    _qtdPessoas.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _form("Valor Total", _total),
              _form("Quantidade de Pessoas", _qtdPessoas),
              _botaoCalcular(),
              const SizedBox(height: 15),
              _botaoLimpar()
            ],
          ),
        ));
  }

  _form(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validarCampo(s!, field),
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

  String? _validarCampo(String text, String field) {
    if (text.isEmpty || int.parse(text) < 1) {
      return "$field deve ser maior que 0!";
    }
    return null;
  }

  _botaoCalcular() {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _calcular();
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

  void _calcular() {
    setState(() {
      double valor = double.parse(_total.text);
      double qtpessoas = double.parse(_qtdPessoas.text);
      double vruni = (valor / qtpessoas) + (qtpessoas);
      double total = valor;
      String vruniStr = vruni.toStringAsPrecision(4);
      String vrtotal = total.toStringAsPrecision(4);
      print("Valor Para Cada Um: $vruniStr"
          "\nValor Total da Conta: $vrtotal");
    });
  }
}
