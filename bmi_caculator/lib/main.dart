import 'package:bmi_caculator/screens/input_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: Color(0xFF0A0E21)),
      ),
      title: 'BMI Calculator',
      home: InputPage(),
    );
  }
}
