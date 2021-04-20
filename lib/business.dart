import 'package:assurance/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'category.dart';


class Business extends StatefulWidget{
  @override
  _BusinessState createState() => _BusinessState();
}
class _BusinessState extends State<Business>{
  String _dropDownBusiness;
  String _dropDownTimeBusiness;
  final auth = FirebaseAuth.instance;

  Widget _appBarTitle = new Text( 'Business Cover');
  final databaseReference = Firestore.instance;
  void createRecord() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Cover Details")
        .updateData({
      'Cover':'$_appBarTitle' ,
      'Type of Cover':'$_dropDownBusiness' ,
      'Period of cover':'$_dropDownTimeBusiness' ,

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Register()));
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
              hint: _dropDownBusiness == null
                  ? Text('Type of cover')
                  : Text(
                _dropDownBusiness,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Professional liability insurance', 'Property insurance','Workers compensation insurance','Home-based businesses','Product liability insurance','Vehicle insurance','Business interruption insurance'].map(
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
                    _dropDownBusiness = val;
                  },
                );
              },
            ),
            new DropdownButton<String>(
              hint: _dropDownTimeBusiness == null
                  ? Text('Period of cover')
                  : Text(
                _dropDownTimeBusiness,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['3 Years', '6 Years','9 Years','12 Years','15 Years'].map(
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
                    _dropDownTimeBusiness = val;
                  },
                );
              },
            ),
            TextField(
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
                  onPressed: () async {
                    createRecord();
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