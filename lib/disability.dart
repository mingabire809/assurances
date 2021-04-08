import 'package:flutter/material.dart';

import 'category.dart';
import 'home.dart';

class Disability extends StatefulWidget{
  @override
  _DisabilityState createState() => _DisabilityState();
}
class _DisabilityState extends State<Disability>{

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Category()));
          },
        );
      }),
      title: Text("Disability"),
    ),
    body: Container(
      child: ListView(
        children:<Widget> [
          TextField(
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