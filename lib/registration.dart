import 'package:assurance/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/auth.dart';
class Registration extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  DateTime selectData;
  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  DateTime birthDate; // instance of DateTime
  String birthDateInString;

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _professionController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  String _dropDownValue;
  final auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          );
        }),
        title: Text(
          "Account Creation",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _fullnameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "My Full Name",
                labelText: "Full Name*",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.mail),
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "name@email.com",
                labelText: "E-mail*",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _phonenumberController,
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                fillColor: Colors.white,
                focusColor: Colors.white,
                prefixText: "+257",
                hintText: "where to reach you",
                labelText: "Phone Number*",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.phone,
              cursorColor: Colors.black54,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _professionController,
              decoration: InputDecoration(
                icon: Icon(Icons.work),
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Income Source",
                labelText: "Profession*",
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
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                icon: Icon(Icons.home),
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Your residence",
                labelText: "Address*",
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
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
                child: new Icon(Icons.calendar_today),
                onTap: () async {
                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(1900),
                      lastDate: new DateTime(2100));
                  if (datePick != null && datePick != birthDate) {
                    setState(() {
                      birthDate = datePick;
                      isDateSelected = true;

                      // put it here
                      birthDateInString =
                          "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                    });
                  }
                }),
            Text(isDateSelected
                ? DateFormat.yMMMd().format(birthDate)
                : initValue),
            SizedBox(
              height: 30.0,
            ),
            new DropdownButton<String>(
              hint: _dropDownValue == null
                  ? Text('Select your Gender')
                  : Text(
                      _dropDownValue,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Male', 'Female'].map(
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
                    _dropDownValue = val;
                  },
                );
              },
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  fillColor: Colors.white,
                  labelText: "Password",
                  hintText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  )),
              maxLength: 12,
              cursorColor: Colors.black12,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _repasswordController,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  fillColor: Colors.white,
                  labelText: "Confirm Password",
                  hintText: "Re-type password",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  )),
              maxLength: 12,
              cursorColor: Colors.black12,
              obscureText: true,
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
                  onPressed: () {
                    _fullnameController.clear();
                    _emailController.clear();
                    _phonenumberController.clear();
                    _addressController.clear();
                    _professionController.clear();
                    _passwordController.clear();
                    _repasswordController.clear();
                  },
                ),
                RaisedButton(
                    child: Text("Register"),
                    color: Colors.lightBlueAccent,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  onPressed: () {

                      if (_passwordController.text ==
                          _repasswordController.text) {


                            auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                            .then((currentUser) => Firestore.instance
                            .collection("users")
                            .document(currentUser.user.uid)
                            .setData({
                          "Full name": _fullnameController.text,
                          "Email": _emailController.text,
                          "Phone Number": _phonenumberController.text,
                          "Profession": _professionController.text,
                          "Address": _addressController.text,
                          "BirthDate": birthDateInString,
                          "Gender": _dropDownValue,

                        })
                            .then((result) => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                                  (_) => true),
                          _fullnameController.clear(),
                          _emailController.clear(),
                          _phonenumberController.clear(),
                          _professionController.clear(),
                          _addressController.clear(),
                          _passwordController.clear(),
                          _repasswordController.clear(),
                        })
                            .catchError((err) => print(err)))
                            .catchError((err) => print(err));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("The passwords do not match"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }

                  },
                ),
                   /* onPressed: () {
                      auth
                          .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
                      });
                    }*/
                    /*onPressed: () {
                    if (_passwordController.text != _repasswordController.text)
                      _showMyDialog();
                    else
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyHomePage()));
                  },*/
      ]
                    )
              ],
        )
            ),

        );



  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Icon(Icons.error),
                Text('Passwords do not match!!', textAlign: TextAlign.center)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
