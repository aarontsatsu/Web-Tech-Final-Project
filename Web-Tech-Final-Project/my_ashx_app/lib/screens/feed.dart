import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_ashx_app/screens/posts.dart';
import 'package:my_ashx_app/user.dart';
import 'package:my_ashx_app/screens/profile.dart';
import 'package:my_ashx_app/http_request.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key : key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> 
{

  final StreamController<List<dynamic>> _streamController = StreamController();

  @override
  void dispose(){
    _streamController.close();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      getPosts();
     });
  }

  Future<void> getPosts() async {
    String postURI = "http://127.0.0.1:8080/posts";

    final response = await http.get(Uri.parse(postURI));

    if (response.statusCode == 200) {
      final json = "[${response.body}]";

      List<dynamic> posts = jsonDecode(json);

      _streamController.sink.add(posts)  ;
      } 
    else {
      throw Exception('Unable to retrieve posts');
    }
  }


  @override
  Widget build(BuildContext context){
    final user_id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect: My Feed"),
        backgroundColor: Color.fromARGB(255, 99, 16, 10),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 16, 10),
              ),
              child: Text('AshX Pages'),
              ),

              ListTile(
              leading: Icon(
                Icons.post_add,
              ),
              title: const Text('Create Post'),
              onTap: () {
                // Navigator.pushNamed(context, '/post');
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostForm(),
                  settings: RouteSettings(
                  arguments: user_id,
                  ),)
                );
              },
              ),

              ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('View Profile'),
              onTap: () async{
                String actualData = await getUser(user_id);
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
                  ),)
                );
              },
              ),

              ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              ),
            ]
          )
        ),
      body:Center(
        child: StreamBuilder<List<dynamic>>(
          stream: _streamController.stream,
          builder: (context, snapdata){
            switch(snapdata.connectionState){
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
              default: if(snapdata.hasData){
                List<dynamic> posts = snapdata.data as List<dynamic>;
                List<dynamic> feed = posts[0];
                List<dynamic> aPost = [];

                for (final post in feed){aPost.add(post);}
                aPost = aPost.reversed.toList();
                return ListView.builder(
                  itemCount: aPost.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(8),
                      color: Color.fromARGB(255, 131, 49, 43),
                      height: 100.0,
                      child: Column(
                        children: <Widget> [
                        ListTile(
                            leading: CircleAvatar(backgroundColor: Color.fromARGB(255, 99, 16, 10)),
                            title: Text(
                                aPost[index]['email']!,
                              ),
                          ),

                          Expanded(
                          child: Container(
                            color: Color.fromARGB(255, 131, 49, 43),
                            child: Center(
                              child: Text(
                                aPost[index]['post']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),

                        ]
                      )
                    ),
                  );
                  },
                );
              }
              if (snapdata.hasError){
                print(snapdata.error.toString());
                return Text('error');
              }
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );  
  }
}