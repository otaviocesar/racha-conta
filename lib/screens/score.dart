import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/controllers/question.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rachaconta/screens/resultado.dart';
import 'package:rachaconta/models/user.dart';
import 'package:rachaconta/providers/users.dart';

class ScoreScreen extends StatelessWidget {
  final _nome = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    final Users users = Provider.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("lib/assets/icons/sun-tornado.svg",
              fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _formName("Nome", _nome),
                  ],
                ),
              ),
              Text(
                "Pontuação:",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Colors.black87),
              ),
              Spacer(),
              Text(
                "${_qnController.correctAns}/${_qnController.questions.length}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white70),
              ),
              Spacer(flex: 3),
              _botaoCadastrar(users, _qnController.correctAns),
              Spacer(flex: 1),
              _botaoFinalizar(),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }

  _formName(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validarNome(s!, field),
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
      ),
    );
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

  _botaoCadastrar(users, qtdAcertos) {
    String qtd = qtdAcertos.toString();
    return SizedBox(
      height: 40,
      width: 1500,
      child: ElevatedButton(
        onPressed: () {
          users
              .put(User(id: "", name: _nome.text, qtdAcertos: qtd, valor: "0"));
        },
        child: const Text("Incluir Resultado"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[800],
        ),
      ),
    );
  }

  _botaoFinalizar() {
    return SizedBox(
      height: 35,
      width: 1500,
      child: ElevatedButton(
        onPressed: () => Get.to(HomePage()),
        child: const Text("Finalizar"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue[800],
        ),
      ),
    );
  }
}
