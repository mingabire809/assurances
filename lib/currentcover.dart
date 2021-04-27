import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'menu.dart';
class CurrentCover extends StatefulWidget {
  @override
  _CurrentCoverState createState() => _CurrentCoverState();
}

class _CurrentCoverState extends State<CurrentCover> {
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
                      MaterialPageRoute(builder: (context) => Menu())
                  );
                },

              );
            }
        ),
        title: Text(
          "Current Cover",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            ListTile(
              leading: Icon(
                Icons.healing,
              ),
              title: Text("Medical Cover"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoadDataFromMedical()),
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
                  MaterialPageRoute(builder: (context) => LoadDataFromHouse()),
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
                  MaterialPageRoute(builder: (context) => LoadDataFromCar()),
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
                  MaterialPageRoute(builder: (context) => LoadDataFromBusiness()),
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
                  MaterialPageRoute(builder: (context) => LoadDataFromDisablity()),
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
                  MaterialPageRoute(builder: (context) => LoadDataFromPension()),
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
                  MaterialPageRoute(builder: (context) => LoadDataFromLife()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class LoadDataFromMedical extends StatefulWidget {
  @override
  _LoadDataFromMedicalState createState() => _LoadDataFromMedicalState();
}

class _LoadDataFromMedicalState extends State<LoadDataFromMedical> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Type Of Cover: ${querySnapshot.data['Type of Cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Period of Cover: ${querySnapshot.data['Period of cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("No Of Person under Cover: ${querySnapshot.data['Number of person under cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),

        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('Medical').get();
  }
}

class LoadDataFromBusiness extends StatefulWidget {
  @override
  _LoadDataFromBusinessState createState() => _LoadDataFromBusinessState();
}

class _LoadDataFromBusinessState extends State<LoadDataFromBusiness> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Type Of Cover: ${querySnapshot.data['Type of Cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Period of Cover: ${querySnapshot.data['Period of cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('Business').get();
  }
}

class LoadDataFromCar extends StatefulWidget {
  @override
  _LoadDataFromCarState createState() => _LoadDataFromCarState();
}

class _LoadDataFromCarState extends State<LoadDataFromCar> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Type Of Cover: ${querySnapshot.data['Type of Cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Period of Cover: ${querySnapshot.data['Period of cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('Car').get();
  }
}

class LoadDataFromDisablity extends StatefulWidget {
  @override
  _LoadDataFromDisabilityState createState() => _LoadDataFromDisabilityState();
}

class _LoadDataFromDisabilityState extends State<LoadDataFromDisablity> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disability Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Amount Assured: ${querySnapshot.data['Amount Assured']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('Disability').get();
  }
}

class LoadDataFromHouse extends StatefulWidget {
  @override
  _LoadDataFromHouseState createState() => _LoadDataFromHouseState();
}

class _LoadDataFromHouseState extends State<LoadDataFromHouse> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("House Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Type Of Cover: ${querySnapshot.data['Type of Cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Period of Cover: ${querySnapshot.data['Period of cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('House').get();
  }
}

class LoadDataFromLife extends StatefulWidget {
  @override
  _LoadDataFromLifeState createState() => _LoadDataFromLifeState();
}

class _LoadDataFromLifeState extends State<LoadDataFromLife> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Life Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Type Of Cover: ${querySnapshot.data['Type of Cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Period of Cover: ${querySnapshot.data['Period of cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Amount Assured: ${querySnapshot.data['Amount Assured']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('Life').get();
  }
}

class LoadDataFromPension extends StatefulWidget {
  @override
  _LoadDataFromPensionState createState() => _LoadDataFromPensionState();
}

class _LoadDataFromPensionState extends State<LoadDataFromPension> {
  @override
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pension Cover Details"),
      ),
      body: _showDetails(),
    );
  }

  Widget _showDetails() {

    if (querySnapshot != null) {
      return ListView(

        children:<Widget> [
          SizedBox(height: 70.0),
          Text("Provider: ${querySnapshot.data['Provider']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Amount Assured: ${querySnapshot.data['Amount Assured']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Period of Cover: ${querySnapshot.data['Period of cover']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Starting Date: ${querySnapshot.data['Starting Date']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Conditions and Agreement: ${querySnapshot.data['Agreement']}",style: TextStyle(fontSize: 25.0),textAlign: TextAlign.center),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).collection('Cover').document('Pension').get();
  }
}