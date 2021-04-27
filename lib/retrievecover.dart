import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Retrieve extends StatefulWidget {
  @override
  _RetrieveState createState() => _RetrieveState();
}

class _RetrieveState extends State<Retrieve> {
  @override
  void initState() {
    super.initState();
    getDriversList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Retriever"),
      ),
      body: _showDrivers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showDrivers() {
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
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Type of Cover: ${querySnapshot.documents[i].data['Type of Cover']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
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

  //get firestore instance
  getDriversList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "SOCABU").getDocuments();
  }
}