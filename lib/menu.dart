import 'dart:io';

import 'package:assurance/about.dart';
import 'package:assurance/camera.dart';
import 'package:assurance/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assurance/locator.dart';
import 'package:assurance/login.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'map.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final auth = FirebaseAuth.instance;
  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    var drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("Full Name"),
      accountEmail: Text("user.name@email.com"),
      decoration: BoxDecoration(color: Colors.black38),
      currentAccountPicture: CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54),
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
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("Profile"),
          onTap: () {
            _showPicker(context);
          },
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.update,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("Update"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Camerawesome()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(
                Icons.question_answer_rounded,
                color: Colors.white,
              ),
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
              child: Icon(
                Icons.map,
                color: Colors.white,
              ),
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
              child: Icon(
                Icons.map,
                color: Colors.white,
              ),
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
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                backgroundColor: Colors.black54),
            title: Text("Logout"),
            onTap: () => showDialog(
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
                        /*onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },*/ //

                        child: Text('Yes'),
                      ),
                    ],
                  );
                })),
        ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54,
            ),
            title: Text("Exit"),
            onTap: () => showDialog(
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
                })),
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
