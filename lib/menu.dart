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
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Profile"),
        ),
        ListTile(
          leading: Icon(Icons.update),
          title: Text("Update"),
        ),
        ListTile(
          leading: Icon(Icons.question_answer_rounded),
          title: Text("About us"),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
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
