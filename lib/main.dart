import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/addtaskpage.dart';
import 'package:flutter_application_1/Pages/welcomepage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-do App',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
