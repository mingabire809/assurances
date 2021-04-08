import 'package:assurance/business.dart';
import 'package:assurance/car.dart';
import 'package:assurance/disability.dart';

import 'package:assurance/house.dart';
import 'package:assurance/life.dart';
import 'package:assurance/medical.dart';
import 'package:assurance/menu.dart';
import 'package:assurance/pension.dart';
import 'package:flutter/material.dart';


class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu())
              );
            },

          );
        }
        ),
        title: Text(
          "Category",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.healing,
              ),
              title: Text("Medical Cover"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Medical()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => House()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Car()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Business()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Disability()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pension()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Life()),
                );
              },
            ),
          ],
        ),
      ),
    );

    // TODO: implement build
  }
}

//class _NewPage extends MaterialPageRoute<void> {
  //_NewPage(String id)
    //  : super(builder: (BuildContext context) {
      //    return Scaffold(
        //    appBar: AppBar(
          //    title: Text(
            //    '$id',
              //  style: TextStyle(color: Colors.black),
              //),
              //elevation: 1.0,
            //),
            //body: Container(

            //),
          //);
        //});
//}
