import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key : key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> 
{
  @override
  Widget build(BuildContext context){
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: Text("AshX Social Connect: My Feed"),
        backgroundColor: Color.fromARGB(255, 99, 16, 10),
        // actions: <Widget>[
        //   IconButton(
        //   icon: Icon(Icons.search), 
        //   onPressed: (){}),
        // ],
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon:Icon(Icons.home), text: "Home"),
            Tab(icon:Icon(Icons.post_add), text: "Create Post"),
            Tab(icon:Icon(Icons.person), text: "Profile")
            ]
          )
        ),
      backgroundColor: Colors.white,

      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => CardItem(),
      ),

    ),
  );
}

}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child:Container(
        height: 300.0,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(backgroundColor: Color.fromARGB(255, 99, 16, 10)),
              title: Text("Aaron Tsatsu Tamakloe"),
              subtitle: Text("Time and Date Okay"),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 131, 49, 43),
                child: Center(
                  child: Text(
                    "Here's my first post",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  