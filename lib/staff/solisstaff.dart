import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../login.dart';


class SolisStaff extends StatefulWidget {
  @override
  _SolisStaffState createState() => _SolisStaffState();
}

class _SolisStaffState extends State<SolisStaff> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.logout),

                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Do you want to logout?'),
                          actions: [
                            FlatButton(
                              onPressed: () =>
                                  Navigator.pop(context, false), // passing false
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () {
                                auth.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      })

              );
            }
        ),
        title: Text("Solis"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.black,
              iconSize: 28.0,
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Do you want to exit?'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.pop(context, false),
                          // passing false
                          child: Text('No'),
                        ),
                        FlatButton(
                          onPressed: () {
                            auth.signOut();
                            exit(0);
                          }, // passing true
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  })
          ),
        ],
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisMedical()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisHouse()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisCar()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisBusiness()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisDisability()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisPension()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SolisLife()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SolisMedical extends StatefulWidget {
  @override
  _SolisMedicalState createState() => _SolisMedicalState();
}

class _SolisMedicalState extends State<SolisMedical> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("Medical Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Type of Cover: ${querySnapshot.documents[i].data['Type of Cover']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Number of person Under Cover: ${querySnapshot.documents[i].data['Number of person under cover']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "Medical Cover").getDocuments();
  }
}

class SolisHouse extends StatefulWidget {
  @override
  _SolisHouseState createState() => _SolisHouseState();
}

class _SolisHouseState extends State<SolisHouse> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("House Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Type of Cover: ${querySnapshot.documents[i].data['Type of Cover']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "House Cover").getDocuments();
  }
}

class SolisCar extends StatefulWidget {
  @override
  _SolisCarState createState() => _SolisCarState();
}

class _SolisCarState extends State<SolisCar> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("Car Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Type of Cover: ${querySnapshot.documents[i].data['Type of Cover']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Plate Number: ${querySnapshot.documents[i].data['Plate Number']}"),
              SizedBox(height: 10.0),
              Text("Chassis Number: ${querySnapshot.documents[i].data['Chassis Number']}"),
              SizedBox(height: 10.0),
              Text("Horse Power: ${querySnapshot.documents[i].data['Horse Power']}"),
              SizedBox(height: 10.0),
              Text("Number Of Seats: ${querySnapshot.documents[i].data['Number Of Seats']}"),
              SizedBox(height: 10.0),
              ({querySnapshot.documents[i].data['Number Of Seats']} != null)
                  ? Image.network("${querySnapshot.documents[i].data['Number Of Seats']}")
                  : Placeholder(fallbackHeight: 200.0,fallbackWidth: double.infinity),
              SizedBox(height: 10.0,),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "Car Cover").getDocuments();
  }
}

class SolisBusiness extends StatefulWidget {
  @override
  _SolisBusinessState createState() => _SolisBusinessState();
}

class _SolisBusinessState extends State<SolisBusiness> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("Business Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Type of Cover: ${querySnapshot.documents[i].data['Type of Cover']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Amount Assured: ${querySnapshot.documents[i].data['Amount Assured']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "Business Cover").getDocuments();
  }
}

class SolisDisability extends StatefulWidget {
  @override
  _SolisDisabilityState createState() => _SolisDisabilityState();
}

class _SolisDisabilityState extends State<SolisDisability> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("Disability Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Amount Assured: ${querySnapshot.documents[i].data['Amount Assured']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "Disability Cover").getDocuments();
  }
}

class SolisPension extends StatefulWidget {
  @override
  _SolisPensionState createState() => _SolisPensionState();
}

class _SolisPensionState extends State<SolisPension> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("Pension Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Amount Assured: ${querySnapshot.documents[i].data['Amount Assured']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "Pension Cover").getDocuments();
  }
}

class SolisLife extends StatefulWidget {
  @override
  _SolisLifeState createState() => _SolisLifeState();
}

class _SolisLifeState extends State<SolisLife> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  final userRef = Firestore.instance.collection('Cover');
  void details(){
    userRef.getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
  }
  QuerySnapshot querySnapshot;
  sendEmailApproval(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your Cover Request has been approved and you are required to pay'
          'the premium through our Ecocash Number 05475, Lumicash Number 65475'
          'or To account Number 0154778745 in BBCI',
      subject: 'Cover request Approval',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  sendEmailDenial(String emailAddress) async {
    final Email email = Email(
      body:
      'Greetings,'
          'Your request for The following cover has been denied.'
          'You can reach through Our line or reapply for the cover.' ,
      subject: 'Cover request Denial',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SolisStaff()));
            },
          );
        }),
        title: Text("Life Cover Request"),
      ),
      body: _showCovers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showCovers() {
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
//load data into widgets
              SizedBox(height: 25.0),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Customer Name: ${querySnapshot.documents[i].data['Name']}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Decision'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            sendEmailDenial("${querySnapshot.documents[i].data['Email']}"), // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
              SizedBox(height: 10.0),
              Text("Customer Name: ${querySnapshot.documents[i].data['Name']}"),
              SizedBox(height: 10.0),
              Text("Phone Number: ${querySnapshot.documents[i].data['Phone Number']}"),
              SizedBox(height: 10.0),
              Text("E-mail Address: ${querySnapshot.documents[i].data['Email']}"),
              SizedBox(height: 10.0),
              Text("Cover: ${querySnapshot.documents[i].data['Cover']}"),
              SizedBox(height: 10.0),
              Text("Provider: ${querySnapshot.documents[i].data['Provider']}"),
              SizedBox(height: 10.0),
              Text("Type of Cover: ${querySnapshot.documents[i].data['Type of cover']}"),
              SizedBox(height: 10.0),
              Text("Amount Assured: ${querySnapshot.documents[i].data['Amount Assured']}"),
              SizedBox(height: 10.0),
              Text("Period of Cover: ${querySnapshot.documents[i].data['Period of cover']}"),
              SizedBox(height: 10.0),
              Text("Starting Date: ${querySnapshot.documents[i].data['Starting Date']}"),
              SizedBox(height: 10.0),
              Text("Term and Conditions: ${querySnapshot.documents[i].data['Agreement']}"),
              SizedBox(height: 25.0),
            ],
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getCoverList() async {
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "MUTUALITE SOLIS").where("Cover",isEqualTo: "Life Cover").getDocuments();
  }
}


