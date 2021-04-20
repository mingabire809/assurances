import 'package:assurance/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'category.dart';

class Pension extends StatefulWidget{
  @override
  _PensionState createState() => _PensionState();
}
class _PensionState extends State<Pension>{
  String _dropDownTime;
  final _amount = TextEditingController();
  final auth = FirebaseAuth.instance;

  Widget _appBarTitle = new Text( 'Pension Cover');
  final databaseReference = Firestore.instance;
  void createRecord() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Cover Details")
        .updateData({
      'Cover':'$_appBarTitle' ,
      'Period of cover':'$_dropDownTime' ,
      'Amount Assured': _amount,

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
           new DropdownButton<String>(
             hint: _dropDownTime == null
                 ? Text('Period')
                 : Text(
               _dropDownTime,
               style: TextStyle(color: Colors.black),
             ),
             isExpanded: true,
             iconSize: 30.0,
             style: TextStyle(color: Colors.black),
             items: ['5 Years', '10 Years','15 Years','20 Years','25 Years','30 Years'].map(
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
                   _dropDownTime = val;
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