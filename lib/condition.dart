import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'package:assurance/medical.dart';

class Condition extends StatefulWidget{
  final auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    // here you write the codes to input the data into firestore
  }
  @override
  _ConditionState createState() => _ConditionState();
}
class _ConditionState extends State<Condition>{
  final auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }
  bool checkedValue = false;
  DateTime selectData;
  String initValue = "Select your Debut Date";
  bool isDateSelected = false;
  DateTime coverStarting; // instance of DateTime
  String birthDateInString;
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and conditions"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            GestureDetector(
                child: new Icon(Icons.calendar_today),
                onTap: () async {
                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(1900),
                      lastDate: new DateTime(2100));
                  if (datePick != null && datePick != coverStarting) {
                    setState(() {
                      coverStarting = datePick;
                      isDateSelected = true;

                      // put it here
                      birthDateInString =
                      "${coverStarting.month}/${coverStarting.day}/${coverStarting.year}";
                    });
                  }
                }),
            Text(isDateSelected
                ? DateFormat.yMMMd().format(coverStarting)
                : initValue),
            SizedBox(height: 10.0),
            Image.asset('images/condition.jpg'),
            SizedBox(height: 10.0,),
            CheckboxListTile(
              title: Text("Conditions and agreement"),
              value: checkedValue,
              onChanged: (newValue) {
                setState(() {
                  checkedValue = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
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
                  child: Text("I agree"),
                  color: Colors.lightBlueAccent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  onPressed: () async {
                    if(checkedValue != false) {
                      String instructor = (await FirebaseAuth.instance
                          .currentUser()).uid;
                      await databaseReference.collection("users")
                          .document(instructor).collection('Cover').document(
                          "Cover Details")
                          .updateData({
                        'Starting Date': '$birthDateInString',
                         'Agreement': 'I Agree that the following Insurance company'
                                      ' will be covering me and that I will provide all '
                                       'the required information for the period of cover',

                      }).then((_) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Condition"),
                                content: Text("The Request has been completed!"
                                       "Your provider will be in touch with you Shortly"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                                    },
                                  )
                                ],
                              );
                            });

                      });
                    }
                    else
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Condition"),
                              content: Text("You must agree Terms and Conditions!!"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
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