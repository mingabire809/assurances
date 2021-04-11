import 'package:assurance/socabu.dart';
import 'package:assurance/socar.dart';
import 'package:assurance/solis.dart';
import 'package:assurance/ucar.dart';
import 'package:flutter/material.dart';

import 'ascoma.dart';
import 'bicor.dart';
import 'businessinsurance.dart';
import 'egiv.dart';
import 'home.dart';
import 'jubilee.dart';
import 'mfp.dart';

class Partner extends StatefulWidget {
  @override
  _PartnerState createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black,
                size: 20.0,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            );
          }),
          title: Text("Our Partner", style: TextStyle(color: Colors.black),),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/partner.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/socabu.png"),
                ),
                title: Text(
                  "SOCABU",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Socabu()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/ascoma.png"),
                ),
                title: Text(
                  "ASCOMA",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ascoma()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/bicor.png"),
                ),
                title: Text(
                  "BICOR",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bicor()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/jubilee.jpg"),
                ),
                title: Text(
                  "JUBILEE",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Jubilee()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/mfp.jpg"),
                ),
                title: Text(
                  "MUTUELLE DE LA FONCTION PUBLIQUE",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mfp()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/solis.png"),
                ),
                title: Text(
                  "MUTUALITE SOLIS",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Solis()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/egicnv.jpg"),
                ),
                title: Text(
                  "EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EastAfrica()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/socar.jpg"),
                ),
                title: Text(
                  "SOCAR",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Socar()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/ucar.jpg"),
                ),
                title: Text(
                  "UCAR",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ucar()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/bic.jpg"),
                ),
                title: Text(
                  "BUSINESS INSURANCE & REINSURANCE",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessInsurance()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
