import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login.dart';


class UcarStaff extends StatefulWidget {
  @override
  _UcarStaffState createState() => _UcarStaffState();
}

class _UcarStaffState extends State<UcarStaff> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.logout),

                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Do you want to logout?'),
                          actions: [
                            FlatButton(
                              onPressed: () =>
                                  Navigator.pop(context, false), // passing false
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () {
                                auth.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      })

              );
            }
        ),
        title: Text("Ucar"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.black,
              iconSize: 28.0,
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Do you want to exit?'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.pop(context, false),
                          // passing false
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
      ),

      body: Container(
        child: ListView(
          children:<Widget> [
            ListTile(
              leading: Icon(
                Icons.healing,
              ),
              title: Text("Medical Cover"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
