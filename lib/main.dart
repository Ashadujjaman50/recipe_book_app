import 'package:flutter/material.dart';

import 'presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book App',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}