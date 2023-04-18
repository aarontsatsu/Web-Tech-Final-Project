import 'package:flutter/material.dart';
import 'package:my_ashx_app/screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Ashx App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: StudentForm(),
      ),
    );
  }
}