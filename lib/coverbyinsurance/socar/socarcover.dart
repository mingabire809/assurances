import 'package:flutter/material.dart';

import '../cover.dart';
class SocarCover extends StatefulWidget {
  @override
  _SocarCoverState createState() => _SocarCoverState();
}

class _SocarCoverState extends State<SocarCover> {
  @override
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
                      MaterialPageRoute(builder: (context) => Cover())
                  );
                },

              );
            }
        ),
        title: Text(
          "Socar",
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

              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
