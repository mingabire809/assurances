import 'package:flutter/material.dart';

import 'category.dart';
import 'home.dart';

class Car extends StatefulWidget{
  @override
  _CarState createState() => _CarState();
}
class _CarState extends State<Car>{
  String _dropDownCar;
  String _dropCover;
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
      title: Text("Car"),
    ),
    body: Container(
      child: ListView(
        children:<Widget> [

          new DropdownButton<String>(
            hint: _dropDownCar
                == null
                ? Text('Type of cover')
                : Text(
              _dropDownCar,
              style: TextStyle(color: Colors.black),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.black),
            items: ['Liability coverage', 'Collision insurance','Comprehensive insurance','Uninsured motorist insurance','Underinsured motorist insurance','Medical payments coverage','Personal injury protection insurance','Gap insurance'].map(
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
            items: ['3 Months', '6 Months','9 Months','1 Year'].map(
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