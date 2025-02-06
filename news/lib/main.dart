import 'package:flutter/material.dart';
import 'package:news/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEWS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 9, 192, 33),
        secondaryHeaderColor: Color.fromARGB(255, 216, 0, 0),
        scaffoldBackgroundColor: const Color.fromARGB(255, 211, 211, 211),
      ),
      home: HomeScreen(),
    );
  }
}
