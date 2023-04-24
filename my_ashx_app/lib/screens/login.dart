import 'dart:convert';
import 'package:my_ashx_app/user.dart';
import 'package:flutter/material.dart';
import 'package:my_ashx_app/http_request.dart';
import 'package:my_ashx_app/screens/profile.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key : key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> 
{
  late int student_id;
  late String password;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect"),
        backgroundColor: Color.fromARGB(255, 99, 16, 10),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  // logo
                  Image.asset(
                    "images/black-student-png.jpg"
                  ),

                  const SizedBox(height: 10),
                  // student id text field
                  TextField(
                    onChanged: (value){
                      student_id = int.parse(value);
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Student ID",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.email, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),

                  // password text field
                  TextField(
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: true,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.password, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 20),
                  // button
                  ElevatedButton(
                    onPressed: ()  {
                      showPostCreationModal();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 99, 16, 10)),
                      foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 99, 16, 10)),
                    ),
                    child: const Text("Login",
                    style: TextStyle(color: Colors.black, letterSpacing: 2, fontSize: 15,))
                  )
                  
                ]
              )
            ),
          ),
        ],
      ),
    );
  }
  void showPostCreationModal() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Log In"),
        content: Text("You have logged in successfully."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () async{
              String actualData = await getUser(student_id);
              var userData = jsonDecode(actualData);
              User data =  User(
                user_id: userData['student_id'],
                name: userData['name'],
                email: userData['email'],
                dob: userData['dob'],
                yearGroup: userData['class'],
                major: userData['major'],
                residence: userData['residence'],
                best_food: userData['best_food'],
                best_movie: userData['best_movie']
              );

              Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                  settings: RouteSettings(
                  arguments: data,
                  ),
                )
              );
            },
          ),
        ],
      );
    },
  );
}
}


