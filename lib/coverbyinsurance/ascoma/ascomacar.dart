import 'package:assurance/coverbyinsurance/ascoma/ascomacover.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../../home.dart';

class AscomaCar extends StatefulWidget {
  @override
  _AscomaCarState createState() => _AscomaCarState();
}

class _AscomaCarState extends State<AscomaCar> {
  String _dropDownCar;
  String _dropCover;
  final noOfSeats = TextEditingController();
  final plateNumber = TextEditingController();
  final horsePower = TextEditingController();
  final chassisNumber = TextEditingController();
  final auth = FirebaseAuth.instance;
  String today =
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  String imageUrl;
  final databaseReference = Firestore.instance;

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance
        .collection('users')
        .document(instructor)
        .get();
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
    await databaseReference
        .collection("users")
        .document(instructor)
        .collection('Cover')
        .document('Car')
        .updateData({
      'Type of Cover': '$_dropDownCar',
      'Period of cover': '$_dropCover',
      'Plate Number': plateNumber.text,
      'Chassis Number': chassisNumber.text,
      'Horse Power': horsePower.text,
      'Number Of Seats': noOfSeats.text,
    }).then((_) async {
      await databaseReference
          .collection("Company")
          .document("Ascoma")
          .collection("Car")
          .document(today)
          .updateData({
        'Name': ' ${querySnapshot.data['Full name']}',
        'Phone Number': ' ${querySnapshot.data['Phone Number']}',
        'Email': '${querySnapshot.data['Email']}',
        'Cover': 'Car Cover',
        'Type of Cover': '$_dropDownCar',
        'Period of cover': '$_dropCover',
        'Plate Number': plateNumber.text,
        'Chassis Number': chassisNumber.text,
        'Horse Power': horsePower.text,
        'Number Of Seats': noOfSeats.text,
        'Car Picture Link': '$imageUrl',
      });
    }).then((_) async {
      await databaseReference.collection("Cover").document(today).updateData({
        'Name': ' ${querySnapshot.data['Full name']}',
        'Phone Number': ' ${querySnapshot.data['Phone Number']}',
        'Email': '${querySnapshot.data['Email']}',
        'Cover': 'Car Cover',
        'Type of Cover': '$_dropDownCar',
        'Period of cover': '$_dropCover',
        'Plate Number': plateNumber.text,
        'Chassis Number': chassisNumber.text,
        'Horse Power': horsePower.text,
        'Number Of Seats': noOfSeats.text,
        'Car Picture Link': '$imageUrl',
      });
    }).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AscomaCarCondition()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AscomaCover()));
              },
            );
          }),
          title: Text("Ascoma Car Cover")),
      body: Container(
        child: ListView(
          children: <Widget>[
            new DropdownButton<String>(
              hint: _dropDownCar == null
                  ? Text('Type of cover')
                  : Text(
                      _dropDownCar,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'Liability coverage',
                'Collision insurance',
                'Comprehensive insurance',
                'Uninsured motorist insurance',
                'Underinsured motorist insurance',
                'Medical payments coverage',
                'Personal injury protection insurance',
                'Gap insurance'
              ].map(
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
              items: ['3 Months', '6 Months', '9 Months', '1 Year'].map(
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
            SizedBox(
              height: 20.0,
            ),
            (imageUrl != null)
                ? Image.network(imageUrl)
                : Placeholder(
                    fallbackHeight: 200.0, fallbackWidth: double.infinity),
            FlatButton(
                onPressed: () => uploadImage(),
                child: Text('Upload Car Picture')),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: plateNumber,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Plate Number",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: chassisNumber,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Chassis Number",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: horsePower,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Horse Power",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: noOfSeats,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Number of Seats",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.number,
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
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

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('${querySnapshot.data['Full name']}/Car')
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}

class AscomaCarCondition extends StatefulWidget {
  @override
  _AscomaCarConditionState createState() => _AscomaCarConditionState();
}

class _AscomaCarConditionState extends State<AscomaCarCondition> {
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
                          .document("Business")
                          .updateData({
                        'Starting Date': '$birthDateInString',
                        'Agreement': 'I Agree that the following Insurance company'
                            ' will be covering me and that I will provide all '
                            'the required information for the period of cover',
                      }).then((_) async {
                        await databaseReference
                            .collection("Company")
                            .document("Ascoma")
                            .collection('Car')
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
