import 'package:assurance/category.dart';
import 'package:assurance/condition.dart';
import 'package:assurance/disability.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'home.dart';

class RegisterDisability extends StatefulWidget{
  @override
  _RegisterDisabilityState createState() => _RegisterDisabilityState();
}
class _RegisterDisabilityState extends State<RegisterDisability>{
  final databaseReference = Firestore.instance;
  String today =  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Disability()));
            },
          );
        }),
        title: Text("Register"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.socabu.png"),
              ),
              title: Text(
                "SOCABU",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'SOCABU' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'SOCABU',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/ascoma.png"),
              ),
              title: Text(
                "ASCOMA",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'ASCOMA' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'ASCOMA',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.bicor.png"),
              ),
              title: Text(
                "BICOR",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'BICOR' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'BICOR',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.jubilee.jpg"),
              ),
              title: Text(
                "JUBILEE",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disablity")
                    .updateData({
                  'Provider':'JUBILEE' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'JUBILEE',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.mfp.jpg"),
              ),
              title: Text(
                "MUTUELLE DE LA FONCTION PUBLIQUE",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disabilty")
                    .updateData({
                  'Provider':'MFP' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'MFP',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.solis.png"),
              ),
              title: Text(
                "MUTUALITE SOLIS",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'MUTUALITE SOLIS' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'MUTUALITE SOLIS',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/egicnv.jpg"),
              ),
              title: Text(
                "EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Cover Details")
                    .updateData({
                  'Provider':'EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.socar.jpg"),
              ),
              title: Text(
                "SOCAR",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'SOCAR' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'SOCAR',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },

            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/coverbyinsurance.ucar.jpg"),
              ),
              title: Text(
                "UCAR",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'UCAR' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'UCAR',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/bic.jpg"),
              ),
              title: Text(
                "BUSINESS INSURANCE & REINSURANCE",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () async {
                String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                await databaseReference.collection("users")
                    .document(instructor).collection('Cover').document("Disability")
                    .updateData({
                  'Provider':'BUSINESS INSURANCE & REINSURANCE' ,

                }).then((_) async {
                  await databaseReference.collection("Cover")
                      .document(today)
                      .updateData({
                    'Provider': 'BUSINESS INSURANCE & REINSURANCE',

                  });
                }).then((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConditionDisability()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }

}
class ConditionDisability extends StatefulWidget{
  final auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    // here you write the codes to input the data into firestore
  }
  @override
  _ConditionDisabilityState createState() => _ConditionDisabilityState();
}
class _ConditionDisabilityState extends State<ConditionDisability>{
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
                          "Disability")
                          .updateData({
                        'Starting Date': '$birthDateInString',
                        'Agreement': 'I Agree that the following Insurance company'
                            ' will be covering me and that I will provide all '
                            'the required information for the period of cover',

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