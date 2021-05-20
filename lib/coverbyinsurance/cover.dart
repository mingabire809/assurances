import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/egiv/egivcover.dart';
import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/jubilee/jubileecover.dart';
import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/mfp/mfpcover.dart';
import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/socabu/socabucover.dart';
import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/socar/socarcover.dart';
import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/solis/soliscover.dart';
import 'file:///C:/Users/ZEBRA/AndroidStudioProjects/assurance/lib/coverbyinsurance/ucar/ucarcover.dart';
import 'package:assurance/menu.dart';
import 'package:flutter/material.dart';

import 'ascoma/ascomacover.dart';
import 'bicor/bicorcover.dart';
import 'businessinsurance/businessinsurancecover.dart';
class Cover extends StatefulWidget {
  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> {
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
                    MaterialPageRoute(builder: (context) => Menu()));
              },
            );
          }),
          title: Text("Preferred Company", style: TextStyle(color: Colors.black),),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/company.jpg"),
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
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SocabuCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/ascoma.png"),
                ),
                title: Text(
                  "ASCOMA",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AscomaCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/bicor.png"),
                ),
                title: Text(
                  "BICOR",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BicorCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/jubilee.jpg"),
                ),
                title: Text(
                  "JUBILEE",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JubileeCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/mfp.jpg"),
                ),
                title: Text(
                  "MUTUELLE DE LA FONCTION PUBLIQUE",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MfpCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/solis.png"),
                ),
                title: Text(
                  "MUTUALITE SOLIS",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SolisCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/egicnv.jpg"),
                ),
                title: Text(
                  "EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EastAfricaCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/socar.jpg"),
                ),
                title: Text(
                  "SOCAR",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SocarCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/ucar.jpg"),
                ),
                title: Text(
                  "UCAR",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UcarCover()),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/bic.jpg"),
                ),
                title: Text(
                  "BUSINESS INSURANCE & REINSURANCE",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessInsuranceCover()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
