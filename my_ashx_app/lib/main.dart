import 'package:flutter/material.dart';
import 'package:my_ashx_app/screens/signup.dart';
import 'package:my_ashx_app/screens/login.dart';
import 'package:my_ashx_app/screens/posts.dart';
import 'package:my_ashx_app/screens/edit_profile.dart';
import 'package:my_ashx_app/screens/feed.dart';
import 'package:my_ashx_app/screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Ashx App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("Error");
          }
          if(snapshot.connectionState == ConnectionState.done){
            return LoginForm();
          }
          return CircularProgressIndicator();

        }
      ),
      initialRoute: '/login', // Initial route
      //pages routes for app
      routes: {
        '/login': (context) => LoginForm(),
        '/post': (context) => PostForm(),
        '/signup': (context) => StudentForm(),
        '/editProfile' : (context) => EditProfile(),
        '/feed' : (context) => Feed(),
        '/profile' : (context) => Profile()
      },
    );
  }
}