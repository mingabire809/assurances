

import 'dart:convert';
import 'dart:io';
import 'package:assurance/staff.dart';
import 'package:assurance/staff/ascomastaff.dart';
import 'package:assurance/staff/bicorstaff.dart';
import 'package:assurance/staff/businessinsurancestaff.dart';
import 'package:assurance/staff/egivstaff.dart';
import 'package:assurance/staff/jubileestaff.dart';
import 'package:assurance/staff/mfpstaff.dart';
import 'package:assurance/staff/socabustaff.dart';
import 'package:assurance/staff/socarstaff.dart';
import 'package:assurance/staff/solisstaff.dart';
import 'package:assurance/staff/ucarstaff.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registration.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final databaseReference = Firestore.instance;
  String error ;
  final GlobalKey<State> _loadingKey = GlobalKey<State>();
  Future printIps() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');
      await databaseReference.collection("users")
          .document(instructor)
          .updateData({
        'Current Ipv4 address':'== Interface: ${interface.name} ==',

      });
      for (var addr in interface.addresses) {

        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
        await databaseReference.collection("users")
            .document(instructor)
            .updateData({
          'Current Ipv6 address':'${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}',

        });
      }
    }
  }
  Future<String> lookupUserCountry() async {
    final response = await http.get('https://api.ipregistry.co?key=tryout');

    if (response.statusCode == 200) {
      print(json.decode(response.body)['location']['country']['name']);

    } else {
      throw Exception('Failed to get user country from IP address');
    }
  }
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
        title: Text("Authentification Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
            iconSize: 28.0,
            onPressed: () => showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Do you want to exit?'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, false),
                // passing false
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0), // passing true
                child: Text('Yes'),
              ),
            ],
          );
        })
          ),
        ],
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
                //controller: _usernameController,
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
                onChanged: (value) {
                  setState(() {
                    _usernameController.text = value.trim();
                  });
                },

              ),

              TextField(
              //  controller: _passwordController,
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
                onChanged: (value) {
                  setState(() {
                    _passwordController.text = value.trim();
                  });
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
                      onPressed: () async {
                      /*  auth.signInWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text).then((_){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
                        });*/
                        //_signInWithEmailAndPassword();

                        signInWithEmailAndPassword();
                      }

                    /*onPressed: () {
                      if (_usernameController.text != "Assurance" &&  _passwordController.text != "password")

                        _showMyDialog();

                      else
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MyHomePage()));


                    },*/
                  )

                ],
              ),
            ],
          )),
    );

  }
  Future<void> _signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text).then((_){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
      });
      } catch (e) {
        _showMyDialog(); // TODO: show dialog with error
      }
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
  Future<void> signInWithEmailAndPassword() async{

    //final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    //firebaseAuth
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text)
          .then((currentUser) {
        Firestore.instance
            .collection('users')
            .document(currentUser.user.uid)
            .get()
            .then((value) async {
          var userType = (value.data)['User Type'];
          if (userType == "Staff") {
          //  Navigator.pushReplacementNamed(context, '/Staff');
           /* Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Staff()));*/
            final GlobalKey<State> _loadingKey = GlobalKey<State>();
           // showLoadingDialog(context, _loadingKey);
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Staff()),
            );
          } else if (userType == "Ascoma Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AscomaStaff()),
            );
          }
          else if (userType == "Bicor Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BicorStaff()),
            );
          }
          else if (userType == "Business Insurance and Reinsurance Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()),
            );
          }
          else if (userType == "East Africa Global Insurance Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EastAfricaStaff()),
            );
          }
          else if (userType == "Jubilee Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JubileeStaff()),
            );
          }
          else if (userType == "Mfp Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MfpStaff()),
            );
          }
          else if (userType == "Socabu Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SocabuStaff()),
            );
          }
          else if (userType == "Socar Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SocarStaff()),
            );
          }
          else if (userType == "Solis Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SolisStaff()),
            );
          }
          else if (userType == "Ucar Staff"){
            await Future.delayed(Duration(seconds: 8));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UcarStaff()),
            );
          }
          else {
           // Navigator.pushReplacementNamed(context, '/MyHomePage');
           /* Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()));*/
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }
        });
      }
      ).then((_) {
        printIps();
        lookupUserCountry();
      });
    } catch (e) {
  _showMyDialog(); // TODO: show dialog with error
  }
  }
}
