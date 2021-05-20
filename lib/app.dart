import 'package:assurance/staff.dart';
import 'package:assurance/usertype.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

import 'package:firebase_auth/firebase_auth.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Assurance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //stream: FirebaseAuth.instance.onAuthStateChanged,
      home: MyHomePage(title: 'Assurance'),
      initialRoute: '/login',
      onGenerateRoute: _getLogin,
    );
  }
}

Route<dynamic> _getLogin(RouteSettings settings) {
  return MaterialPageRoute<void>(
    builder: (BuildContext context) => Landing(),
  );
}

class Landing extends StatelessWidget {
 //final String instructor = (await FirebaseAuth.instance.currentUser()).uid;
 /* Future <void>userTypes() {
    final  user = FirebaseAuth.instance.currentUser().then((currentUser) {
    //  String userid = currentUser..uid;
      Firestore.instance
          .collection('users')
          .document(currentUser.uid)
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

    });
   /* String instructor = (await FirebaseAuth.instance.currentUser()).uid;
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
    });*/
  }*/
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser> (
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return Login();
          }
         /* else if(user != null){

              FirebaseUser user;
              String uid = user.uid;
              Firestore.instance
                  .collection('users')
                  .document(uid)
                  .get()
                  .then((value) {
                var userType = (value.data)['User Type'];
                if (userType == "Staff")  {

                  return Staff();
                 // return MyHomePage();
                }
                else {
                  //return Staff();
                  return MyHomePage();
                }
              });
             // String instructor = (await FirebaseAuth.instance.currentUser()).uid;
            /*  Firestore.instance
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
              });*/


          }*/
          // return UserType();
         // return userTypes();
          //return MyHomePage()?? Staff();//?? MyHomePage();// ?? Staff();
          //return Staff() ?? MyHomePage();
          return MyHomePage();

        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
