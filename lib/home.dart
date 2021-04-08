
import 'package:flutter/material.dart';

import 'menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 20.0,
              semanticLabel: 'Menu',
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Text(
          "Assurance",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              iconSize: 28.0,
              onPressed: null),

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/path.jpg"),
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
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/ascoma.png"),
              ),
              title: Text(
                "ASCOMA",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/bicor.png"),
              ),
              title: Text(
                "BICOR",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/jubilee.jpg"),
              ),
              title: Text(
                "JUBILEE",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/mfp.jpg"),
              ),
              title: Text(
                "MUTUELLE DE LA FONCTION PUBLIQUE",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/solis.png"),
              ),
              title: Text(
                "MUTUALITE SOLIS",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/egicnv.jpg"),
              ),
              title: Text(
                "EAST AFRICA GLOBAL INSURANCE COMPANY NON-VIE",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/socar.jpg"),
              ),
              title: Text(
                "SOCAR",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/ucar.jpg"),
              ),
              title: Text(
                "UCAR",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/bic.jpg"),
              ),
              title: Text(
                "BUSINESS INSURANCE & REINSURANCE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Menu(),
    );
  }
}
