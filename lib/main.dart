import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rachaconta/providers/users.dart';
import 'package:rachaconta/screens/welcome.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: GetMaterialApp(
        title: 'Racha Conta com Quiz',
        theme: ThemeData.dark(),
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
