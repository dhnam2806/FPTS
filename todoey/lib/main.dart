import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey/screens/bloc/task_bloc.dart';
import 'package:todoey/screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todoey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskScreen(),
    );
  }
}
