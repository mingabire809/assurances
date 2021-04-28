import 'package:assurance/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState(){
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message)async{
        print("onMessage: $message");
        final snackbar = SnackBar(content: Text(message['notification']['title']),
        action: SnackBarAction(
          label: 'Go',
          onPressed: () => null,
        ) ,
        );
        Scaffold.of(context).showSnackBar(snackbar);
        showDialog(context: context,
          builder: (context)=> AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['title']['body']),
            ),
            actions:<Widget> [
              FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('OK'))
            ],
          )
        );
      },
        onResume: (Map<String, dynamic> message)async{
      print("onResume: $message");
      showDialog(context: context,
          builder: (context)=> AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['title']['body']),
            ),
            actions:<Widget> [
              FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('OK'))
            ],
          )
      );
    },
        onLaunch: (Map<String, dynamic> message)async{
          print("onLaunch: $message");
          showDialog(context: context,
              builder: (context)=> AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['title']['body']),
                ),
                actions:<Widget> [
                  FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('OK'))
                ],
              )
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage())
            );
          },

        );
      }
  ),
  title: Text("Notifications"),

),
      body: Container(
        child: ListView(
          children:<Widget> [
           // Text()
          ],
        ),
      ),
    );
  }
  _saveDeviceToken() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
  }
}
