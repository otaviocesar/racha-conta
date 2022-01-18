import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/data/users_data.dart';
import 'package:rachaconta/models/user.dart';
import 'package:rachaconta/views/user_list.dart';
import 'package:rachaconta/providers/users.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({Key? key}) : super(key: key);

  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  final _valorTotal = TextEditingController();
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
    _valorTotal.text = "";
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
              _form("Valor Total", _valorTotal),
              _botaoLimpar(),
              const SizedBox(height: 15),
              _botaoCalcular(users, _qtdPessoas, _valorTotal),
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

  _botaoCalcular(users, _qtdPessoas, _valorTotal) {
    return SizedBox(
      height: 40,
      width: 1500,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _calcular(users, _qtdPessoas, _valorTotal);
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

  void _calcular(users, _qtdPessoas, _valorTotal) {
    setState(() {
      int questoes = 5;
      print("valorTotal: " + _valorTotal.text);
      int valorTotal = int.parse(_valorTotal.text);
      var quantidadePessoas = _qtdPessoas;
      print("quantidadePessoas:" + quantidadePessoas.toString());
      double media = valorTotal / quantidadePessoas;
      print("media:" + media.toString());
      double total = 0;
      double sobra = 0;

      for (int i = 0; i < quantidadePessoas; i++) {
        print("qtdAcertos: " + users.byIndex(i).qtdAcertos.toString());
        int qtdAcertos = int.parse(users.byIndex(i).qtdAcertos);

        int erros = questoes - qtdAcertos;
        print("erros: " + erros.toString());
        double porcentagemMais = 1 + (erros / questoes);
        print("porcentagemMais: " + porcentagemMais.toString());
        double valor = media * porcentagemMais;
        print("valor: " + valor.toString());
        double sobraParcial = media - valor;
        print("sobraParcial: " + sobraParcial.toString());
        sobra = sobra + sobraParcial;
        users.put(User(
            id: users.byIndex(i).id,
            name: users.byIndex(i).name,
            qtdAcertos: users.byIndex(i).qtdAcertos,
            valor: valor.toString()));
      }

      for (int i = 0; i < quantidadePessoas; i++) {
        double valorAtual = double.parse(users.byIndex(i).valor);
        double valorPagar = valorAtual + (sobra / quantidadePessoas);
        users.put(User(
            id: users.byIndex(i).id,
            name: users.byIndex(i).name,
            qtdAcertos: users.byIndex(i).qtdAcertos,
            valor: valorPagar.toString()));
      }

      for (int i = 0; i < quantidadePessoas; i++) {
        double valorAtualMaisSobra = double.parse(users.byIndex(i).valor);
        total = total + valorAtualMaisSobra;
      }
      print(total);
    });
  }
}
