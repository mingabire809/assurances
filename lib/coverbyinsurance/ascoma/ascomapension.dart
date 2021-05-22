import 'package:assurance/coverbyinsurance/ascoma/ascomacover.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home.dart';
class AscomaPension extends StatefulWidget {
  @override
  _AscomaPensionState createState() => _AscomaPensionState();
}

class _AscomaPensionState extends State<AscomaPension> {
  String _dropDownTime;
  final _amount = TextEditingController();
  final auth = FirebaseAuth.instance;
  String today =  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  final databaseReference = Firestore.instance;
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
  void pension() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection('Cover').document('Pension')
        .updateData({
      'Period of cover':'$_dropDownTime' ,
      'Amount Assured': _amount.text,


    }).then((_) async {
      await databaseReference
          .collection("Company")
          .document("Ascoma")
          .collection('Pension')
          .document(today)
          .updateData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'Pension Cover' ,
        'Period of cover':'$_dropDownTime' ,
        'Amount Assured': _amount.text,
      });
    }).then((_) async {
      await databaseReference.collection("Cover")
          .document(today)
          .updateData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'Pension Cover' ,
        'Period of cover':'$_dropDownTime' ,
        'Amount Assured': _amount.text,


      });
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AscomaMedicalCondition()));
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
                  context, MaterialPageRoute(builder: (context) => AscomaCover()));
            },
          );
        }),
        title: Text("Ascoma Pension Cover"),
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
                    pension();
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

class AscomaMedicalCondition extends StatefulWidget {
  @override
  _AscomaMedicalConditionState createState() => _AscomaMedicalConditionState();
}

class _AscomaMedicalConditionState extends State<AscomaMedicalCondition> {
  bool checkedValue = false;
  DateTime selectData;
  String initValue = "Select your Debut Date";
  bool isDateSelected = false;
  DateTime coverStarting; // instance of DateTime
  String birthDateInString;
  final databaseReference = Firestore.instance;
  String today =
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and conditions"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
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
            SizedBox(
              height: 10.0,
            ),
            CheckboxListTile(
              title: Text("Conditions and agreement"),
              value: checkedValue,
              onChanged: (newValue) {
                setState(() {
                  checkedValue = newValue;
                });
              },
              controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                    if (checkedValue != false) {
                      String instructor =
                          (await FirebaseAuth.instance.currentUser()).uid;
                      await databaseReference
                          .collection("users")
                          .document(instructor)
                          .collection('Cover')
                          .document("Pension")
                          .updateData({
                        'Starting Date': '$birthDateInString',
                        'Agreement': 'I Agree that the following Insurance company'
                            ' will be covering me and that I will provide all '
                            'the required information for the period of cover',
                      }).then((_) async {
                        await databaseReference
                            .collection("Company")
                            .document("Ascoma")
                            .collection('Pension')
                            .document(today)
                            .updateData({
                          'Starting Date': '$birthDateInString',
                          'Agreement': 'I Agree that the following Insurance company'
                              ' will be covering me and that I will provide all '
                              'the required information for the period of cover',
                        });
                      }).then((_) async {
                        await databaseReference
                            .collection("Cover")
                            .document(today)
                            .updateData({
                          'Starting Date': '$birthDateInString',
                          'Agreement': 'I Agree that the following Insurance company'
                              ' will be covering me and that I will provide all '
                              'the required information for the period of cover',
                        });
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
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()));
                                    },
                                  )
                                ],
                              );
                            });
                      });
                    } else
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Condition"),
                              content:
                              Text("You must agree Terms and Conditions!!"),
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
