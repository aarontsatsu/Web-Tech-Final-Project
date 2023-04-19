import 'package:flutter/material.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key : key);

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> 
{
  // final _formKey = GlobalKey<FormState>();
  String studentId = "";
  String name = "";
  String email = "";
  DateTime dob = DateTime.now();
  int yearGroup = 0;
  String major = "";
  bool hasResidence = false;
  String bestFood = "";
  String bestMovie = "";

  // void _submitForm() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     // Submit the form
  //     // You can handle the form submission logic here
  //     print('Student ID: $_studentId');
  //     print('Name: $_name');
  //     print('Email: $_email');
  //     print('Date of Birth: $_dob');
  //     print('Year Group: $_yearGroup');
  //     print('Major: $_major');
  //     print('Has Residence: $_hasResidence');
  //     print('Best Food: $_bestFood');
  //     print('Best Movie: $_bestMovie');
  //   }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  // logo
                  Image.asset(
                    "images/black-student-png.jpg"
                  ),

                  const SizedBox(height: 20),
                  // studentId text field
                  TextField(
                    onChanged: (value){
                      studentId = value;
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Student ID",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.person, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),
                  // name text field
                  TextField(
                    onChanged: (value){
                      name = value;
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.person_4, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 20),
                  // button
                  ElevatedButton(
                    onPressed: (){

                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text("Sign Up",
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
}