// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_ashx_app/http_request.dart';
import 'package:my_ashx_app/user.dart';
import 'package:my_ashx_app/screens/feed.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key : key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> 
{
  final TextEditingController student_id = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController yearGroup = TextEditingController();
  final TextEditingController major = TextEditingController();
  final TextEditingController residence = TextEditingController();
  final TextEditingController best_food = TextEditingController();
  final TextEditingController best_movie = TextEditingController();
  
  var residences = ['On-Campus', 'Off-Campus'];

  String val = 'On-Campus';

  @override
  Widget build(BuildContext context){

    final data = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect: Edit Profile"),
        backgroundColor: Color.fromARGB(255, 99, 16, 10),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child:ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width:4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO9E7z4dQCIxqyJjV4zpilCPDTR3kfrBoQGQ&usqp=CAU"
                          )
                        )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Column(
                children: <Widget>[
                  _studentIDControl(data.user_id.toString()),
                  SizedBox(height: 10),
                  _emailControl(data.email),
                  SizedBox(height: 10),
                  _nameControl(data.name),
                  SizedBox(height: 10),
                  _dobControl(data.dob),
                  SizedBox(height: 10),
                  _yearGroupControl(data.yearGroup.toString()),
                  SizedBox(height: 10),
                  _majorControl(data.major),
                  SizedBox(height: 10),
                  _residenceControl(data.residence),
                  SizedBox(height: 10),
                  _foodControl(data.best_food),
                  SizedBox(height: 10),
                  _movieControl(data.best_movie),
                  SizedBox(height: 10)
                ]
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ), 
                    child: Text("Cancel", style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.black
                    )),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      var body = {
                        "dob":dob.text,
                        "class":int.parse(yearGroup.text),
                        "major":major.text,
                        "residence":residence.text,
                        "best_food":best_food.text,
                        "best_movie":best_movie.text
                      };
                      try {
                        await editUser(body, data.user_id);
                        showPostCreationModal();
                      } catch (e) {
                        print("Could not process request");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 99, 16, 10),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: Text("Update Info", style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white
                    )),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void showPostCreationModal() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edit Profile"),
        content: Text("You have successfully updated your profile."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: (){
            //   String actualData = await getUser(int.parse(student_id.text));
            //   var userData = jsonDecode(actualData);
            //   User data =  User(
            //   user_id: int.parse(userData['student_id']),
            //   name: userData['name'],
            //   email: userData['email'],
            //   dob: userData['dob'],
            //   yearGroup: int.parse(userData['class']),
            //   major: userData['major'],
            //   residence: userData['residence'],
            //   best_food: userData['best_food'],
            //   best_movie: userData['best_movie']
            // );
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Feed(),
              settings: RouteSettings(
              arguments: int.parse(student_id.text),
              ),)
            );
            },
          ),
        ],
      );
    },
  );
}

Widget _studentIDControl(String initialValue){
  student_id.text = initialValue;
  return TextFormField(
    controller: student_id,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Student ID",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _emailControl(String initialValue){
  email.text = initialValue;
  return TextFormField(
    controller: email,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Email",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _nameControl(String initialValue){
  name.text = initialValue;
  return TextFormField(
    controller: name,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Name",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _dobControl(String initialValue){
  dob.text = initialValue;
  return TextFormField(
    controller: dob,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Date of Birth",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _yearGroupControl(String initialValue){
  yearGroup.text = initialValue;
  return TextFormField(
    controller: yearGroup,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Year Group",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _majorControl(String initialValue){
  major.text = initialValue;
  return TextFormField(
    controller: major,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Major",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _residenceControl(String initialValue){
  
  return DropdownButtonFormField<String>(
    value: val,
    items: residences.map((String items) {
    return DropdownMenuItem<String>(
      value: items,
      child: Text(items),
    );
  }).toList(),
  onChanged: (String? newValue) {
      val = newValue!;
      setState(() {
        residence.text = newValue;
      });
    },
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Student Residence",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.home, color:Colors.black,)
    ),
  );
}

Widget _foodControl(String initialValue){
  best_food.text = initialValue;
  return TextFormField(
    controller: best_food,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Major",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}

Widget _movieControl(String initialValue){
  best_movie.text = initialValue;
  return TextFormField(
    controller: best_movie,
    style: TextStyle(fontSize: 15, color: Colors.black),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      hintText: "Major",
      hintStyle: TextStyle(color: Colors.grey),
      icon: Icon(Icons.computer, color:Colors.black,)
    )
  );
}
}