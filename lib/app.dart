import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
