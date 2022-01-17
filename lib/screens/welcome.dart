import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rachaconta/screens/quiz/quiz.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("lib/assets/icons/sun-tornado.svg",
              fit: BoxFit.fill),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 40,
                    width: 1500,
                    child: ElevatedButton(
                      onPressed: () => Get.to(QuizScreen()),
                      child: const Text("Iniciar Quiz"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[800],
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
