import 'package:flutter/material.dart';
import 'child_homescreen.dart';
import 'childpecs.dart';
import 'parenthomepage.dart';
import 'questions_by_parents.dart';
import 'create_question.dart';
import 'dependents.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO app',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Dependents()
    );
  }
}
