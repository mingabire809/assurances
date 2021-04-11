import 'dart:io';

import 'package:assurance/about.dart';
import 'package:assurance/category.dart';
import 'package:assurance/locator.dart';
import 'package:assurance/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'map.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("Full Name"),
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
              child: Icon(Icons.map,color: Colors.white,),
              backgroundColor: Colors.black54),
          title: Text("Map"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Map()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.map,color: Colors.white,),
              backgroundColor: Colors.black54),
          title: Text("My position"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Locator()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.logout,color: Colors.white,), backgroundColor: Colors.black54),
          title: Text("Logout"),
          onTap: ()=> showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Do you want to logout?'),
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context, false), // passing false
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }, // passing true
                      child: Text('Yes'),
                    ),
                  ],
                );
              })
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.close, color: Colors.white,), backgroundColor: Colors.black54,
          ),
            title: Text("Exit"),
            onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Do you want to exit?'),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context, false), // passing false
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () => exit(0), // passing true
                        child: Text('Yes'),
                      ),
                    ],
                  );
                })

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

