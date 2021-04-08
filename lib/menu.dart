import 'package:assurance/about.dart';
import 'package:assurance/category.dart';
import 'package:assurance/login.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("UserName"),
      accountEmail: Text("user.name@email.com"),
      decoration: BoxDecoration(color: Colors.black38),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage("images/profile.jpg"),
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
      SizedBox(height: 20.0,),
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.home,color: Colors.white,), backgroundColor: Colors.black54),
          title: Text("Home"),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("images/cover.jpg"),
          ),
          title: Text("Cover"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.person,color: Colors.white,), backgroundColor: Colors.black54),
          title: Text("Profile"),
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.update,color: Colors.white,),
            backgroundColor: Colors.black54,
          ),
          title: Text("Update"),
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.question_answer_rounded,color: Colors.white,),
              backgroundColor: Colors.black54),
          title: Text("About us"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => About()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.logout,color: Colors.white,), backgroundColor: Colors.black54),
          title: Text("Logout"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ],
    );
    return Scaffold(
      body: Container(
        child: drawerItems,
        color: Colors.white,
      ),
    );
  }
}
