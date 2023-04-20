import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key : key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> 
{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect"),
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
              buildTextField("Name", "Aaron"),
              buildTextField("Best Food", "Jollof"),
              buildTextField("Best Movie", "American Gangstar"),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){},
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
                    onPressed: (){},
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
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            )
        )
      )
    );
  }
}