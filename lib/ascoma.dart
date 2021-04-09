import 'package:assurance/home.dart';
import 'package:flutter/material.dart';

import 'about.dart';


class Ascoma extends StatefulWidget {
  @override
  _AscomaState createState() => _AscomaState();
}

class _AscomaState extends State<Ascoma>{
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
        title: Text("Ascoma"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/ascoma.png'),
            SizedBox(height: 20.0,),
            /*ListTile(
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