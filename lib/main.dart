import 'package:flutter/material.dart';
import './random_words.dart';

void main() {
  runApp(const MyApp());
}

// primarySwatch: Colors.blue,
// super - untuk mengakses parent dari object saat ini
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This WIDGET is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', theme: ThemeData(), home: const RandomWords());
  }
}
