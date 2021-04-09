import 'package:assurance/home.dart';
import 'package:flutter/material.dart';

import 'about.dart';


class Socar extends StatefulWidget {
  @override
  _SocarState createState() => _SocarState();
}

class _SocarState extends State<Socar>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          );
        }),
        title: Text("Socar"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/socar.jpg'),
            SizedBox(height: 20.0,),
           /* ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/cover.jpg"),
              ),
              title: Text("Our Services"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Category()),
                );
              },
            ),*/
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.question_answer_rounded,color: Colors.white,),
                  backgroundColor: Colors.black54),
              title: Text("About us"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}