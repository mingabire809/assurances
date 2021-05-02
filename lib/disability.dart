import 'package:assurance/register.dart';
import 'package:assurance/registerdisability.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'category.dart';


class Disability extends StatefulWidget{
  @override
  _DisabilityState createState() => _DisabilityState();
}
class _DisabilityState extends State<Disability>{
  final _amount = TextEditingController();
  final auth = FirebaseAuth.instance;
  String today =  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  Widget _appBarTitle = new Text( 'Disability Cover');
  final databaseReference = Firestore.instance;
  void createRecord() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Cover Details")
        .updateData({
      'Cover':'$_appBarTitle' ,
      'Amount Assured':_amount.text ,

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Register()));
    });
  }
  void createDisability() async{

    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Disability")
        .setData({
      'Amount Assured':_amount.text ,
      'Provider': '',
      'Starting Date': '',
      'Agreement': '',

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterDisability()));
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
  void disability() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection('Cover').document('Disability')
        .setData({
      'Amount Assured':_amount.text ,
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
        'Cover':'Disability Cover' ,
        'Amount Assured':_amount.text ,
        'Provider': '',
        'Starting Date': '',
        'Agreement': '',

      },merge: true);
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterDisability()));
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
          TextField(
            controller: _amount,
            decoration: InputDecoration(
              icon: Icon(Icons.monetization_on_sharp),
              fillColor: Colors.white,
              focusColor: Colors.white,
              labelText: "Amount Assured",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.text,
            cursorColor: Colors.black54,
            style: TextStyle(
              color: Colors.black,
            ),
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
                // createRecord();
                 // createDisability();
                  disability();
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