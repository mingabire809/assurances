import 'package:assurance/register.dart';
import 'package:flutter/material.dart';

import 'category.dart';


class Life extends StatefulWidget{
  @override
  _LifeState createState() => _LifeState();
}
class _LifeState extends State<Life>{
  String _dropDownTypeLife;
  String _dropDownTimeLife;
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
    title: Text("Life"),
  ),
  body: Container(
    child: ListView(
      children:<Widget> [
        new DropdownButton<String>(
          hint: _dropDownTypeLife == null
              ? Text('Type of cover')
              : Text(
            _dropDownTypeLife,
            style: TextStyle(color: Colors.black),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.black),
          items: ['W.L.A', 'T.L.A','O.E.A','P.E.A'].map(
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
                _dropDownTypeLife = val;
              },
            );
          },
        ),
        new DropdownButton<String>(
          hint: _dropDownTimeLife == null
              ? Text('Period of cover')
              : Text(
            _dropDownTimeLife,
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
                _dropDownTimeLife = val;
              },
            );
          },
        ),
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
                    MaterialPageRoute(builder: (context) => Register()));
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