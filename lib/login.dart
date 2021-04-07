import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _unfocusedColor = Colors.white;

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/login.jpg"),
            fit: BoxFit.cover,
          )),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/assurance.png"),
                    radius: 35.0,
                  ),
                  Text(
                    "Assurance",
                    style: TextStyle(fontSize: 32.0, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 160.0,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  labelText: "Username",
                  labelStyle: TextStyle(
                    color: Colors.lightBlueAccent,
                  ),
                ),
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),


                ),

              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.lightBlueAccent,
                    )),
                cursorColor: Colors.black12,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
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
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  RaisedButton(
                      child: Text("Enter"),
                      color: Colors.lightBlueAccent,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ],
          )),
    );
  }
}