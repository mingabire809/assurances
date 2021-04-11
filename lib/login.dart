import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registration.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String error ;

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.person_add),

                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registration())
                  );
                },

              );
            }
        ),
      ),
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
                height: 120.0,
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
                      if (_usernameController.text != "Assurance" &&  _passwordController.text != "password")

                      _showMyDialog();

                      else
                      Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MyHomePage()));


                    },)

                ],
              ),
            ],
          )),
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

                Text('Authentication error!!',
                textAlign: TextAlign.center)

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
