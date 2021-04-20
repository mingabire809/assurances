import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoadDataFromFirestore extends StatefulWidget {
  @override
  _LoadDataFromFirestoreState createState() => _LoadDataFromFirestoreState();
}

class _LoadDataFromFirestoreState extends State<LoadDataFromFirestore> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: _showDetails(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showDetails() {

    if (querySnapshot != null) {
     return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Full Name: ${querySnapshot.data['Full name']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Birth Date: ${querySnapshot.data['BirthDate']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("E-mail Adress: ${querySnapshot.data['Email']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Address: ${querySnapshot.data['Address']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Gender: ${querySnapshot.data['Gender']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Phone Number: ${querySnapshot.data['Phone Number']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Profession: ${querySnapshot.data['Profession']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).get();
  }
}