import 'package:assurance/register.dart';
import 'package:assurance/registerhouse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'category.dart';


class House extends StatefulWidget{
  @override
  _HouseState createState() => _HouseState();
}
class _HouseState extends State<House>{
  String _dropDownType;
  String _dropDownPeriod;
  final auth = FirebaseAuth.instance;
  String today =  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  Widget _appBarTitle = new Text( 'House Insurance');
  final databaseReference = Firestore.instance;
  void createRecord() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Cover Details")
        .updateData({
      'Cover':'$_appBarTitle' ,
      'Type of Cover':'$_dropDownType' ,
      'Period of cover':'$_dropDownPeriod' ,

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Register()));
    });
  }
  void createHouse() async{

    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("House")
        .setData({

      'Type of Cover':'$_dropDownType' ,
      'Period of cover':'$_dropDownPeriod' ,
      'Provider': '',
      'Starting Date': '',
      'Agreement': '',

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterHouse()));
    });

  }
  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).get();
  }
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  void house() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection('Cover').document('House')
        .setData({
      'Type of Cover':'$_dropDownType' ,
      'Period of cover':'$_dropDownPeriod' ,
      'Provider': '',
      'Starting Date': '',
      'Agreement': '',

    }).then((_) async {
      await databaseReference.collection("Cover")
          .document(today)
          .setData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'House Cover' ,
        'Type of Cover':'$_dropDownType' ,
        'Period of cover':'$_dropDownPeriod' ,
        'Provider': '',
        'Starting Date': '',
        'Agreement': '',

      },merge: true);
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterHouse()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category()));
            },
          );
        }),
        title: _appBarTitle,
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            new DropdownButton<String>(
              hint: _dropDownType == null
                  ? Text('Type of cover')
                  : Text(
                _dropDownType,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Theft', 'Fire','Natural Calamities','all'].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    _dropDownType = val;
                  },
                );
              },
            ),
            new DropdownButton<String>(
              hint: _dropDownPeriod == null
                  ? Text('Period of cover')
                  : Text(
                _dropDownPeriod,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['1 Year', '2 Years','3 Years','4 Years'].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    _dropDownPeriod = val;
                  },
                );
              },
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  color: Colors.black38,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: null,
                ),
                RaisedButton(
                  child: Text("Proceed"),
                  color: Colors.lightBlueAccent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  onPressed: () {
                  //  createRecord();
                   // createHouse();
                    house();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}