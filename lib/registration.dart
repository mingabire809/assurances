import 'package:assurance/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'login.dart';

class Registration extends StatefulWidget {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
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