import 'package:flutter/material.dart';

import 'category.dart';
import 'home.dart';

class House extends StatefulWidget{
  @override
  _HouseState createState() => _HouseState();
}
class _HouseState extends State<House>{
  String _dropDownType;
  String _dropDownPeriod;
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
        title: Text("House"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            new DropdownButton<String>(
              hint: _dropDownType == null
                  ? Text('Type of cover')
                  : Text(
                _dropDownType,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Theft', 'Fire','Natural Calamities','all'].map(
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
                    _dropDownType = val;
                  },
                );
              },
            ),
            new DropdownButton<String>(
              hint: _dropDownPeriod == null
                  ? Text('Period of cover')
                  : Text(
                _dropDownPeriod,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['1 Year', '2 Years','3 Years','4 Years'].map(
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
                    _dropDownPeriod = val;
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