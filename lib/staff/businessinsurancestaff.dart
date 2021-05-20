import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../login.dart';


class BusinessInsuranceStaff extends StatefulWidget {
  @override
  _BusinessInsuranceStaffState createState() => _BusinessInsuranceStaffState();
}

class _BusinessInsuranceStaffState extends State<BusinessInsuranceStaff> {
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
        title: Text("Business Insurance and Reinsurance"),
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
                          onPressed: (){
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
                    builder: (context) => BusinessInsuranceMedical()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessInsuranceHouse()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessInsuranceCar()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessInsuranceBusiness()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessInsuranceDisability()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessInsurancePension()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessInsuranceLife()));
              },
            ),
          ],
        ),
      ),
    );
  }
}


class BusinessInsuranceMedical extends StatefulWidget {
  @override
  _BusinessInsuranceMedicalState createState() => _BusinessInsuranceMedicalState();
}

class _BusinessInsuranceMedicalState extends State<BusinessInsuranceMedical> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "Medical Cover").getDocuments();
  }
}

class BusinessInsuranceHouse extends StatefulWidget {
  @override
  _BusinessInsuranceHouseState createState() => _BusinessInsuranceHouseState();
}

class _BusinessInsuranceHouseState extends State<BusinessInsuranceHouse> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "House Cover").getDocuments();
  }
}

class BusinessInsuranceCar extends StatefulWidget {
  @override
  _BusinessInsuranceCarState createState() => _BusinessInsuranceCarState();
}

class _BusinessInsuranceCarState extends State<BusinessInsuranceCar> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "Car Cover").getDocuments();
  }
}

class BusinessInsuranceBusiness extends StatefulWidget {
  @override
  _BusinessInsuranceBusinessState createState() => _BusinessInsuranceBusinessState();
}

class _BusinessInsuranceBusinessState extends State<BusinessInsuranceBusiness> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "Business Cover").getDocuments();
  }
}

class BusinessInsuranceDisability extends StatefulWidget {
  @override
  _BusinessInsuranceDisabilityState createState() => _BusinessInsuranceDisabilityState();
}

class _BusinessInsuranceDisabilityState extends State<BusinessInsuranceDisability> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "Disability Cover").getDocuments();
  }
}

class BusinessInsurancePension extends StatefulWidget {
  @override
  _BusinessInsurancePensionState createState() => _BusinessInsurancePensionState();
}

class _BusinessInsurancePensionState extends State<BusinessInsurancePension> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "Pension Cover").getDocuments();
  }
}

class BusinessInsuranceLife extends StatefulWidget {
  @override
  _BusinessInsuranceLifeState createState() => _BusinessInsuranceLifeState();
}

class _BusinessInsuranceLifeState extends State<BusinessInsuranceLife> {
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
                  context, MaterialPageRoute(builder: (context) => BusinessInsuranceStaff()));
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "BUSINESS INSURANCE & REINSURANCE").where("Cover",isEqualTo: "Life Cover").getDocuments();
  }
}




