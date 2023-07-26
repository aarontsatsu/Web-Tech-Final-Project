import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:my_ashx_app/http_request.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key : key);

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> 
{
  late String student_id;
  late String name;
  late String email;
  late String dob;
  late int yearGroup;
  late String major;
  late String residence = residences[0];
  late String best_food;
  late String best_movie;

  final List<String> residences = ['On-Campus', 'Off-Campus'];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect: Sign Up"),
        backgroundColor: Color.fromARGB(255, 99, 16, 10),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .9,
              child:SingleChildScrollView(
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
                      student_id = value;
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
                      dob = value;
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
                  // residence drop down field
                  DropdownButtonFormField<String>(
                    onChanged: (String? newValue) {
                      setState(() {
                        residence = newValue!;
                      });
                    },
                    items: residences.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Student Residence",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.home, color:Colors.black,)
                    ),
                  ),

                  
                  const SizedBox(height: 10),
                  // food text field
                  TextField(
                    onChanged: (value){
                      best_food = value;
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
                      best_movie = value;
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
                    onPressed: () async{
                      var body = {
                        "student_id":student_id,
                        "name":name,
                        "email":email,
                        "dob":dob,
                        "class":yearGroup,
                        "major":major,
                        "residence":residence,
                        "best_food":best_food,
                        "best_movie":best_movie
                      };
                      try {
                        await createUser(body);
                        showPostCreationModal();
                      } catch (e) {
                        print("Could not process request");
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 99, 16, 10)),
                      foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 99, 16, 10)),
                    ),
                    child: const Text("Sign Up",
                    style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 15,))
                  )
                  
                ]
              )
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
        title: Text("Sign Up"),
        content: Text("You have signed up successfully."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      );
    },
  );
}
}