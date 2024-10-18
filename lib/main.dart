import 'package:flutter/material.dart';
import 'package:youbloom_task/UI/Home/home.dart';
import 'package:youbloom_task/UI/Login/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
