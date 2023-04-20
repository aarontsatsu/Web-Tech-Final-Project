import 'package:flutter/material.dart';
import 'package:my_ashx_app/screens/signup.dart';
import 'package:my_ashx_app/screens/login.dart';
import 'package:my_ashx_app/screens/posts.dart';
import 'package:my_ashx_app/screens/edit_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  
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
      initialRoute: '/login', // Initial route
      routes: {
        '/login': (context) => LoginForm(),
        '/post': (context) => PostForm(),
        '/signup': (context) => StudentForm(),
        '/editProfile' : (context) => EditProfile()
      },
    );
  }
}