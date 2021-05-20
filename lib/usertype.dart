import 'package:assurance/staff.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
class UserType extends StatefulWidget {
  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  userType() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    Firestore.instance
        .collection('users')
        .document(instructor)
        .get()
        .then((value) {
    var userType = (value.data)['User Type'];
    if (userType == "Staff")  {

    return Staff();
    }
    else {

    return MyHomePage();
    }
    });
  }
  @override
  Widget build(BuildContext context) {

    return userType();
  }
}

