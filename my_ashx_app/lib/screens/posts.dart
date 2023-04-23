import 'package:flutter/material.dart';
import 'package:my_ashx_app/http_request.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key : key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> 
{
  String post = "";
  String email = "";

  
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

                  // email text field
                  TextField(
                    onChanged: (value){
                      post = value;
                    },
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                      hintText: "Create Post...",
                      hintStyle: TextStyle(color: Colors.grey),
                      // contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                      icon: Icon(Icons.book, color:Colors.black,)
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

                  const SizedBox(height: 20),
                  // button
                  ElevatedButton(
                    onPressed: () async{
                      var body = {
                        "post": post,
                        "email": email
                      };
                      try {
                        await createPost(body);
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
                    child: const Text("Create Post",
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
        title: Text("Post Created"),
        content: Text("Your post has been created successfully."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pushNamed(context, '/feed');
            },
          ),
        ],
      );
    },
  );
}
}