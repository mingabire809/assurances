import 'package:assurance/category.dart';
import 'package:assurance/register.dart';
import 'package:flutter/material.dart';



class Medical extends StatefulWidget{
  @override
  _MedicalState createState() => _MedicalState();
}
class _MedicalState extends State<Medical>{
  String _dropDownVal;
  String _dropCover;
  String _dropNumber;
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
        title: Text("Medical Cover"),
      ),
      body: Container(
        child: ListView(
            children: <Widget>[
        new DropdownButton<String>(
          hint: _dropCover == null
              ? Text('Type of cover')
              : Text(
            _dropCover,
            style: TextStyle(color: Colors.black),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.black),
          items: ['PPO', 'HMO','POS','EPOs','IHIP','HSA','HRAs'].map(
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
              new DropdownButton<String>(
                hint: _dropDownVal == null
                    ? Text('Period of Cover')
                    : Text(
                  _dropDownVal,
                  style: TextStyle(color: Colors.black),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: ['3 Months', '6 Months','9 Months','1 Year','2 Years','3 Years'].map(
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
                      _dropDownVal = val;
                    },
                  );
                },
              ),
              new DropdownButton<String>(
                hint: _dropNumber == null
                    ? Text('Number of Person under cover')
                    : Text(
                  _dropNumber,
                  style: TextStyle(color: Colors.black),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: ['1', '2','3','4','5','6','7','8','9','10','More than 10','More than 50','More than 100'].map(
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
                      _dropNumber = val;
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
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )
                ],
              ),

    ]

        )

    )
    );

  }

}