import 'package:flutter/material.dart';
import 'package:flutter_streams/home_screen.dart';
import 'package:flutter_streams/home_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream',
      debugShowCheckedModeBanner: false,
      home: HomeScreen2(),
    );
  }
}
