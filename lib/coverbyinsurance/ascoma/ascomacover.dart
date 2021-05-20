import 'package:assurance/coverbyinsurance/ascoma/ascomabusiness.dart';
import 'package:assurance/coverbyinsurance/ascoma/ascomacar.dart';
import 'package:assurance/coverbyinsurance/ascoma/ascomalife.dart';
import 'package:assurance/coverbyinsurance/ascoma/ascomamedical.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../cover.dart';
import 'ascomadisability.dart';
import 'ascomahouse.dart';
import 'ascomapension.dart';

class AscomaCover extends StatefulWidget {
  @override
  _AscomaCoverState createState() => _AscomaCoverState();
}

class _AscomaCoverState extends State<AscomaCover> {
  final databaseReference = Firestore.instance;
  String today =
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cover()));
            },
          );
        }),
        title: Text(
          "Ascoma",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.healing,
              ),
              title: Text("Medical Cover"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("Medical")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('Medical')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AscomaMedical()));
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("House")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('House')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AscomaHouse()));
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("Car")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('Car')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AscomaCar()));
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("Business")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('Business')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AscomaBusiness()));
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("Disability")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('Disability')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AscomaDisability()));
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("Pension")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('Pension')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AscomaPension()));
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () async {
                String instructor =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference
                    .collection("users")
                    .document(instructor)
                    .collection('Cover')
                    .document("Life")
                    .setData({
                  'Provider': 'ASCOMA',
                }).then((_) async {
                  await databaseReference
                      .collection("Company")
                      .document("Ascoma")
                      .collection('Life')
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) async {
                  await databaseReference
                      .collection("Cover")
                      .document(today)
                      .setData({
                    'Provider': 'ASCOMA',
                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AscomaLife()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
