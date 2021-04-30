import 'package:assurance/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'menu.dart';
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState(){
    super.initState();
    getNotificationList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
   /* _fcm.configure(
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
    );*/
  }
  QuerySnapshot querySnapshot;
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
                MaterialPageRoute(builder: (context) => Menu())
            );
          },

        );
      }
  ),
  title: Text("Notifications"),

),
      body: _showNotifications()
    );
  }
  Widget _showNotifications() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              Text("${querySnapshot.documents[i].data['Title']}"),
              SizedBox(height: 10.0),
              Text("${querySnapshot.documents[i].data['Text']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
  getNotificationList() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('Notification').document(instructor).collection('Personal').getDocuments();
  }
  _saveDeviceToken() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
  }
}
