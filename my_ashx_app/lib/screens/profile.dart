import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key : key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> 
{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect: My Profile"),
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
              buildTextField("Student ID", "49622024"),
              buildTextField("Name", "Aaron"),
              buildTextField("Email", "aarontmkl@gmail.com"),
              buildTextField("DOB", "05/07/2001"),
              buildTextField("Year Group", "2024"),
              buildTextField("Major", "Computer Science"),
              buildTextField("Residence", "On-Campus"),
              buildTextField("Best Food", "Jollof"),
              buildTextField("Best Movie", "American Gangstar"),
              SizedBox(height: 30),

      
              Container(
                width: 100,
                height: 100,
                child: GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [

                      Positioned(
                        bottom: 50,
                        right: 50,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editProfile');
                          },
                          icon: Icon(Icons.edit),
                          color: Color.fromARGB(255, 99, 16, 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}