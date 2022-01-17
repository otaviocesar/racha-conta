import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rachaconta/controllers/question.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    _controller.updateName("nome");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: _controller.nextQuestion, child: const Text("Pular")),
        ],
      ),
      body: Body(),
    );
  }
}
