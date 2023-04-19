import 'package:flutter/material.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key : key);

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> 
{
  String studentId = "";
  String name = "";
  String email = "";
  DateTime dob = DateTime.now();
  int yearGroup = 0;
  String major = "";
  bool hasResidence = false;
  String bestFood = "";
  String bestMovie = "";


  @override
  Widget build(BuildContext context){
    return Scaffold(
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

                  const SizedBox(height: 10),
                  // email text field
                  TextField(
                    onChanged: (value){
                      email = value;
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.email, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),
                  // dob text field
                  TextField(
                    onChanged: (value){
                      dob = DateTime.parse(value);
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Date of Birth",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.calendar_month, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),
                  // year text field
                  TextField(
                    onChanged: (value){
                      yearGroup = int.parse(value);
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Year Group",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.class_, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),
                  // major text field
                  TextField(
                    onChanged: (value){
                      major = value;
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Major",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.class_, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),
                  // residence text field
                  CheckboxListTile(
                    title: const Text('Residence'),
                    value: hasResidence,
                    onChanged: (bool? value) {
                      setState(() {
                        hasResidence = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  const SizedBox(height: 10),
                  // food text field
                  TextField(
                    onChanged: (value){
                      bestFood = value;
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Best Food",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.food_bank, color:Colors.black,)
                    )
                  ),

                  const SizedBox(height: 10),
                  // movie text field
                  TextField(
                    onChanged: (value){
                      bestMovie = value;
                    },
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Best Movie",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.computer, color:Colors.black,)
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