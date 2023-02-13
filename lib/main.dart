import 'package:flutter/material.dart';
import 'package:ricky_and_morty/injector_container.dart';
import 'package:ricky_and_morty/presentation/home_screen.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
