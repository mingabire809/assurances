import 'package:assurance/home.dart';
import 'package:flutter/material.dart';
import 'home.dart';

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
                  MaterialPageRoute(builder: (context) => MyHomePage())
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
              onTap: () =>
                  Navigator.of(context).push(_NewPage("Medical Cover")),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () => Navigator.of(context).push(_NewPage("House")),
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () => Navigator.of(context).push(_NewPage("Car")),
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () => Navigator.of(context).push(_NewPage("Business")),
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () => Navigator.of(context).push(_NewPage("Disability")),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () => Navigator.of(context).push(_NewPage("Pension")),
            ),
          ],
        ),
      ),
    );

    // TODO: implement build
  }
}

class _NewPage extends MaterialPageRoute<void> {
  _NewPage(String id)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '$id',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 1.0,
            ),
          );
        });
}
