import 'package:assurance/category.dart';
import 'package:assurance/condition.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register>{
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
       title: Text("Register"),
     ),
     body: Container(
       child: ListView(
         children: <Widget>[
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/socabu.png"),
             ),
             title: Text(
               "SOCABU",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/ascoma.png"),
             ),
             title: Text(
               "ASCOMA",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/bicor.png"),
             ),
             title: Text(
               "BICOR",
               style: TextStyle(color: Colors.black54),
             ),
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/jubilee.jpg"),
             ),
             title: Text(
               "JUBILEE",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/mfp.jpg"),
             ),
             title: Text(
               "MUTUELLE DE LA FONCTION PUBLIQUE",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/solis.png"),
             ),
             title: Text(
               "MUTUALITE SOLIS",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/egicnv.jpg"),
             ),
             title: Text(
               "EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/socar.jpg"),
             ),
             title: Text(
               "SOCAR",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/ucar.jpg"),
             ),
             title: Text(
               "UCAR",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
           ListTile(
             leading: CircleAvatar(
               backgroundImage: AssetImage("images/bic.jpg"),
             ),
             title: Text(
               "BUSINESS INSURANCE & REINSURANCE",
               style: TextStyle(color: Colors.black54),
             ),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Condition()),
               );
             },
           ),
         ],
       ),
     ),
   );
  }

}