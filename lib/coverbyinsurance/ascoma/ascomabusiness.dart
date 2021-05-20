import 'package:assurance/coverbyinsurance/ascoma/ascomacover.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home.dart';

class AscomaBusiness extends StatefulWidget {
  @override
  _AscomaBusinessState createState() => _AscomaBusinessState();
}

class _AscomaBusinessState extends State<AscomaBusiness> {
  String _dropDownBusiness;
  String _dropDownTimeBusiness;
  final auth = FirebaseAuth.instance;
  final amount = TextEditingController();
  final databaseReference = Firestore.instance;
  String today =
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
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
  void business() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection('Cover').document('Business')
        .updateData({
      'Type of Cover':'$_dropDownBusiness' ,
      'Period of cover':'$_dropDownTimeBusiness' ,
      'Amount Assured':amount.text,


    }).then((_) async {
      await databaseReference
          .collection("Company")
          .document("Ascoma")
          .collection('Business')
          .document(today)
          .updateData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'Business Cover' ,
        'Type of Cover':'$_dropDownBusiness' ,
        'Period of cover':'$_dropDownTimeBusiness' ,
        'Amount Assured':amount.text,
      });
    }).then((_) async {
      await databaseReference.collection("Cover")
          .document(today)
          .updateData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'Business Cover' ,
        'Type of Cover':'$_dropDownBusiness' ,
        'Period of cover':'$_dropDownTimeBusiness' ,
        'Amount Assured':amount.text,

      });
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AscomaBusinessCondition()));
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
        title: Text("Ascoma Business"),
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
              controller: amount,
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

                    business();
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

class AscomaBusinessCondition extends StatefulWidget {
  @override
  _AscomaBusinessConditionState createState() => _AscomaBusinessConditionState();
}

class _AscomaBusinessConditionState extends State<AscomaBusinessCondition> {
  bool checkedValue = false;
  DateTime selectData;
  String initValue = "Select your Debut Date";
  bool isDateSelected = false;
  DateTime coverStarting; // instance of DateTime
  String birthDateInString;
  final databaseReference = Firestore.instance;
  String today =  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
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
                          "Business")
                          .updateData({
                        'Starting Date': '$birthDateInString',
                        'Agreement': 'I Agree that the following Insurance company'
                            ' will be covering me and that I will provide all '
                            'the required information for the period of cover',

                      }).then((_) async {
                        await databaseReference
                            .collection("Company")
                            .document("Ascoma")
                            .collection('Business')
                            .document(today)
                            .updateData({
                          'Starting Date': '$birthDateInString',
                          'Agreement': 'I Agree that the following Insurance company'
                              ' will be covering me and that I will provide all '
                              'the required information for the period of cover',
                        });
                      }).then((_) async {
                        await databaseReference.collection("Cover")
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
