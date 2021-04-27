import 'package:assurance/register.dart';
import 'package:assurance/registercar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'category.dart';


class Car extends StatefulWidget{
  @override
  _CarState createState() => _CarState();
}
class _CarState extends State<Car>{
  String _dropDownCar;
  String _dropCover;
  final auth = FirebaseAuth.instance;

  Widget _appBarTitle = new Text( 'Car');
  final databaseReference = Firestore.instance;
  void createRecord() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Cover Details")
        .updateData({
      'Cover':'$_appBarTitle' ,
      'Type of Cover':'$_dropDownCar' ,
      'Period of cover':'$_dropCover' ,

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Register()));
    });
  }
  void createCar() async{

      String instructor = (await FirebaseAuth.instance.currentUser()).uid;
      await databaseReference.collection("users")
          .document(instructor).collection("Cover").document("Car")
          .setData({

        'Type of Cover':'$_dropDownCar' ,
        'Period of cover':'$_dropCover' ,
        'Provider': '',
        'Starting Date': '',
        'Agreement': '',


      }).then((_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => RegisterCar()));
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
  void car() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection('Cover').document('Car')
        .setData({
      'Type of Cover':'$_dropDownCar' ,
      'Period of cover':'$_dropCover' ,
      'Provider': '',
      'Starting Date': '',
      'Agreement': '',

    }).then((_) async {
      await databaseReference.collection("Cover")
          .document(instructor)
          .setData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'$_appBarTitle' ,
        'Type of Cover':'$_dropDownCar' ,
        'Period of cover':'$_dropCover' ,
        'Provider': '',
        'Starting Date': '',
        'Agreement': '',

      });
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterCar()));
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
            hint: _dropDownCar
                == null
                ? Text('Type of cover')
                : Text(
              _dropDownCar,
              style: TextStyle(color: Colors.black),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.black),
            items: ['Liability coverage', 'Collision insurance','Comprehensive insurance','Uninsured motorist insurance','Underinsured motorist insurance','Medical payments coverage','Personal injury protection insurance','Gap insurance'].map(
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
                  _dropDownCar = val;
                },
              );
            },
          ),
          new DropdownButton<String>(
            hint: _dropCover == null
                ? Text('Period of Cover')
                : Text(
              _dropCover,
              style: TextStyle(color: Colors.black),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.black),
            items: ['3 Months', '6 Months','9 Months','1 Year'].map(
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
                  _dropCover = val;
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
               //   createRecord();
                 // createCar();
                  car();
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