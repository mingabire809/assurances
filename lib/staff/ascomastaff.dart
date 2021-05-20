import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sms/sms.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import '../login.dart';

class AscomaStaff extends StatefulWidget {
  @override
  _AscomaStaffState createState() => _AscomaStaffState();
}

class _AscomaStaffState extends State<AscomaStaff> {


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
        title: Text("Ascoma"),
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
                    builder: (context) => AscomaMedical()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text("House"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AscomaHouse()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_repair,
              ),
              title: Text("Car"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AscomaCar()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text("Business"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AscomaBusiness()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_disabled,
              ),
              title: Text("Disability"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AscomaDisability()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Pension"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text("Life"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AscomaLife()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
class AscomaMedical extends StatefulWidget {
  @override
  _AscomaMedicalState createState() => _AscomaMedicalState();
}

class _AscomaMedicalState extends State<AscomaMedical> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  String _message;
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
 /* sms(){
    SmsSender sender = SmsSender();
    String address = "1234567";

    SmsMessage message = SmsMessage(address, 'Hello flutter!');
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
        setState(() {
          _message = "SMS is sent";
        });
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
        setState(() {
          _message = "SMS is delivered!";
        });
      }
    });
    sender.sendSms(message);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                        onPressed: ()
                                  async {
                                    final Email email = Email(
                                      body: 'Greetings,'
                                          'Your request for The following cover has been denied.'
                                          'You can reach through Our line or reapply for the cover.',
                                      subject: 'Cover request Denial',
                                      recipients: ["${querySnapshot.documents[i]
                                        .data['Email']}"],

                                      isHTML: true,
                                    );

                                    String platformResponse;

                                    try {
                                      await FlutterEmailSender.send(email);
                                      platformResponse = 'success';
                                    } catch (error) {
                                      platformResponse = error.toString();
                                    }
                                    print(platformResponse);


                                   /* final mailtoLink = Mailto(
                                      to: ["${querySnapshot.documents[i]
                                          .data['Email']}"],
                                      cc: ['cc1@example.com', 'cc2@example.com'],
                                      subject: 'Cover request Denial',
                                      body: 'Greetings,'
                                          'Your request for The following cover has been denied.'
                                          'You can reach through Our line or reapply for the cover.',
                                    );
                                    // Convert the Mailto instance into a string.
                                    // Use either Dart's string interpolation
                                    // or the toString() method.
                                    await launch('$mailtoLink');*/
                                  /*  sendEmailDenial(
                                        "${querySnapshot.documents[i]
                                            .data['Email']}")
                                  ;*/


                                      SmsSender sender = SmsSender();
                                      String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                      SmsMessage message = SmsMessage(address, 'Greetings,'
                                          'Your request for The following cover has been denied.'
                                          'You can reach through Our line or reapply for the cover.');
                                      message.onStateChanged.listen((state) {
                                        if (state == SmsMessageState.Sent) {
                                          print("SMS is sent!");
                                          setState(() {
                                            _message = "SMS is sent";
                                          });
                                        } else if (state == SmsMessageState.Delivered) {
                                          print("SMS is delivered!");
                                          setState(() {
                                            _message = "SMS is delivered!";
                                          });
                                        }
                                      });
                                      sender.sendSms(message);
                                    },

                                        // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                          SmsSender senders = SmsSender();
                                          String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                          SmsMessage messages = SmsMessage(address, 'Greetings,'
                                              'Your Cover Request has been approved and you are required to pay'
                                              ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745'

                                          );
                                          messages.onStateChanged.listen((state) {
                                            if (state == SmsMessageState.Sent) {
                                              print("SMS is sent!");
                                              setState(() {
                                                _message = "SMS is sent";
                                              });
                                            } else if (state == SmsMessageState.Delivered) {
                                              print("SMS is delivered!");
                                              setState(() {
                                                _message = "SMS is delivered!";
                                              });
                                            }
                                          });
                                          senders.sendSms(messages);
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "Medical Cover").getDocuments();
  }

}

class AscomaHouse extends StatefulWidget {
  @override
  _AscomaHouseState createState() => _AscomaHouseState();
}

class _AscomaHouseState extends State<AscomaHouse> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  String _message;
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
                  context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                        onPressed: ()
                                  async {
                                    final mailtoLink = Mailto(
                                      to: ["${querySnapshot.documents[i]
                                          .data['Email']}"],
                                      cc: ['cc1@example.com', 'cc2@example.com'],
                                      subject: 'Cover request Denial',
                                      body: 'Greetings,'
                                          'Your request for The following cover has been denied.'
                                          'You can reach through Our line or reapply for the cover.',
                                    );
                                    // Convert the Mailto instance into a string.
                                    // Use either Dart's string interpolation
                                    // or the toString() method.
                                    await launch('$mailtoLink');
                                    sendEmailDenial(
                                        "${querySnapshot.documents[i]
                                            .data['Email']}");
                                    SmsSender sender = SmsSender();
                                    String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                    SmsMessage message = SmsMessage(address, 'Greetings,'
                                        'Your request for The following cover has been denied.'
                                        'You can reach through Our line or reapply for the cover.');
                                    message.onStateChanged.listen((state) {
                                      if (state == SmsMessageState.Sent) {
                                        print("SMS is sent!");
                                        setState(() {
                                          _message = "SMS is sent";
                                        });
                                      } else if (state == SmsMessageState.Delivered) {
                                        print("SMS is delivered!");
                                        setState(() {
                                          _message = "SMS is delivered!";
                                        });
                                      }
                                    });
                                    sender.sendSms(message);
                                  },// passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                          SmsSender sender = SmsSender();
                                          String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                          SmsMessage message = SmsMessage(address, 'Greetings,'
                                              'Your Cover Request has been approved and you are required to pay'
                                              ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745');
                                          message.onStateChanged.listen((state) {
                                            if (state == SmsMessageState.Sent) {
                                              print("SMS is sent!");
                                              setState(() {
                                                _message = "SMS is sent";
                                              });
                                            } else if (state == SmsMessageState.Delivered) {
                                              print("SMS is delivered!");
                                              setState(() {
                                                _message = "SMS is delivered!";
                                              });
                                            }
                                          });
                                          sender.sendSms(message);
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "House Cover").getDocuments();
  }
}

class AscomaCar extends StatefulWidget {
  @override
  _AscomaCarState createState() => _AscomaCarState();
}

class _AscomaCarState extends State<AscomaCar> {
  String imageUrl;

  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  String _message;
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
                  context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                        onPressed: () async {
                                          final mailtoLink = Mailto(
                                            to: ["${querySnapshot.documents[i]
                                                .data['Email']}"],
                                            cc: ['cc1@example.com', 'cc2@example.com'],
                                            subject: 'Cover request Denial',
                                            body: 'Greetings,'
                                                'Your request for The following cover has been denied.'
                                                'You can reach through Our line or reapply for the cover.',
                                          );
                                          // Convert the Mailto instance into a string.
                                          // Use either Dart's string interpolation
                                          // or the toString() method.
                                          await launch('$mailtoLink');
                                          sendEmailDenial(
                                              "${querySnapshot.documents[i]
                                                  .data['Email']}");
                                          SmsSender sender = SmsSender();
                                          String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                          SmsMessage message = SmsMessage(address, 'Greetings,'
                                              'Your request for The following cover has been denied.'
                                              'You can reach through Our line or reapply for the cover.');
                                          message.onStateChanged.listen((state) {
                                            if (state == SmsMessageState.Sent) {
                                              print("SMS is sent!");
                                              setState(() {
                                                _message = "SMS is sent";
                                              });
                                            } else if (state == SmsMessageState.Delivered) {
                                              print("SMS is delivered!");
                                              setState(() {
                                                _message = "SMS is delivered!";
                                              });
                                            }
                                          });
                                          sender.sendSms(message);
                                        }, // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                          SmsSender sender = SmsSender();
                                          String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                          SmsMessage message = SmsMessage(address, 'Greetings,'
                                              'Your Cover Request has been approved and you are required to pay'
                                              ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745');
                                          message.onStateChanged.listen((state) {
                                            if (state == SmsMessageState.Sent) {
                                              print("SMS is sent!");
                                              setState(() {
                                                _message = "SMS is sent";
                                              });
                                            } else if (state == SmsMessageState.Delivered) {
                                              print("SMS is delivered!");
                                              setState(() {
                                                _message = "SMS is delivered!";
                                              });
                                            }
                                          });
                                          sender.sendSms(message);
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "Car Cover").getDocuments();
  }
}
 class AscomaBusiness extends StatefulWidget {
   @override
   _AscomaBusinessState createState() => _AscomaBusinessState();
 }

 class _AscomaBusinessState extends State<AscomaBusiness> {

   @override
   void initState() {
     super.initState();
     getCoverList().then((results) {
       setState(() {
         querySnapshot = results;
       });
     });
   }
   String _message;
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
                   context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                         onPressed: () async {
                                           final mailtoLink = Mailto(
                                             to: ["${querySnapshot.documents[i]
                                                 .data['Email']}"],
                                             cc: ['cc1@example.com', 'cc2@example.com'],
                                             subject: 'Cover request Denial',
                                             body: 'Greetings,'
                                                 'Your request for The following cover has been denied.'
                                                 'You can reach through Our line or reapply for the cover.',
                                           );
                                           // Convert the Mailto instance into a string.
                                           // Use either Dart's string interpolation
                                           // or the toString() method.
                                           await launch('$mailtoLink');
                                           sendEmailDenial(
                                               "${querySnapshot.documents[i]
                                                   .data['Email']}");
                                           SmsSender sender = SmsSender();
                                           String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                           SmsMessage message = SmsMessage(address, 'Greetings,'
                                               'Your request for The following cover has been denied.'
                                               'You can reach through Our line or reapply for the cover.');
                                           message.onStateChanged.listen((state) {
                                             if (state == SmsMessageState.Sent) {
                                               print("SMS is sent!");
                                               setState(() {
                                                 _message = "SMS is sent";
                                               });
                                             } else if (state == SmsMessageState.Delivered) {
                                               print("SMS is delivered!");
                                               setState(() {
                                                 _message = "SMS is delivered!";
                                               });
                                             }
                                           });
                                           sender.sendSms(message);
                                         }, // passing false
                                         child: Text('Denied'),
                                       ),
                                       FlatButton(
                                         onPressed: () {
                                           sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                           SmsSender sender = SmsSender();
                                           String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                           SmsMessage message = SmsMessage(address, 'Greetings,'
                                               'Your Cover Request has been approved and you are required to pay'
                                               ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745');
                                           message.onStateChanged.listen((state) {
                                             if (state == SmsMessageState.Sent) {
                                               print("SMS is sent!");
                                               setState(() {
                                                 _message = "SMS is sent";
                                               });
                                             } else if (state == SmsMessageState.Delivered) {
                                               print("SMS is delivered!");
                                               setState(() {
                                                 _message = "SMS is delivered!";
                                               });
                                             }
                                           });
                                           sender.sendSms(message);
                                         },
                                         child: Text('Approved'),
                                       ),
                                     ],
                                   );
                                 });
                           })
                   ])),
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
     return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "Business Cover").getDocuments();
   }
 }
 class AscomaDisability extends StatefulWidget {
   @override
   _AscomaDisabilityState createState() => _AscomaDisabilityState();
 }

 class _AscomaDisabilityState extends State<AscomaDisability> {

   @override
   void initState() {
     super.initState();
     getCoverList().then((results) {
       setState(() {
         querySnapshot = results;
       });
     });
   }
   String _message;
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
                   context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                         onPressed: () async {
                                           final mailtoLink = Mailto(
                                             to: ["${querySnapshot.documents[i]
                                                 .data['Email']}"],
                                             cc: ['cc1@example.com', 'cc2@example.com'],
                                             subject: 'Cover request Denial',
                                             body: 'Greetings,'
                                                 'Your request for The following cover has been denied.'
                                                 'You can reach through Our line or reapply for the cover.',
                                           );
                                           // Convert the Mailto instance into a string.
                                           // Use either Dart's string interpolation
                                           // or the toString() method.
                                           await launch('$mailtoLink');
                                           sendEmailDenial(
                                               "${querySnapshot.documents[i]
                                                   .data['Email']}");
                                           SmsSender sender = SmsSender();
                                           String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                           SmsMessage message = SmsMessage(address, 'Greetings,'
                                               'Your request for The following cover has been denied.'
                                               'You can reach through Our line or reapply for the cover.');
                                           message.onStateChanged.listen((state) {
                                             if (state == SmsMessageState.Sent) {
                                               print("SMS is sent!");
                                               setState(() {
                                                 _message = "SMS is sent";
                                               });
                                             } else if (state == SmsMessageState.Delivered) {
                                               print("SMS is delivered!");
                                               setState(() {
                                                 _message = "SMS is delivered!";
                                               });
                                             }
                                           });
                                           sender.sendSms(message);
                                         }, // passing false
                                         child: Text('Denied'),
                                       ),
                                       FlatButton(
                                         onPressed: () {
                                           sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                           SmsSender sender = SmsSender();
                                           String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                           SmsMessage message = SmsMessage(address, 'Greetings,'
                                               'Your Cover Request has been approved and you are required to pay'
                                               ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745');
                                           message.onStateChanged.listen((state) {
                                             if (state == SmsMessageState.Sent) {
                                               print("SMS is sent!");
                                               setState(() {
                                                 _message = "SMS is sent";
                                               });
                                             } else if (state == SmsMessageState.Delivered) {
                                               print("SMS is delivered!");
                                               setState(() {
                                                 _message = "SMS is delivered!";
                                               });
                                             }
                                           });
                                           sender.sendSms(message);
                                         },
                                         child: Text('Approved'),
                                       ),
                                     ],
                                   );
                                 });
                           })
                   ])),
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
     return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "Disability Cover").getDocuments();
   }
 }
 class AscomaPension extends StatefulWidget {
   @override
   _AscomaPensionState createState() => _AscomaPensionState();
 }

 class _AscomaPensionState extends State<AscomaPension> {

   @override
   void initState() {
     super.initState();
     getCoverList().then((results) {
       setState(() {
         querySnapshot = results;
       });
     });
   }
   String _message;
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
                   context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                         onPressed: () async {
                                           final mailtoLink = Mailto(
                                             to: ["${querySnapshot.documents[i]
                                                 .data['Email']}"],
                                             cc: ['cc1@example.com', 'cc2@example.com'],
                                             subject: 'Cover request Denial',
                                             body: 'Greetings,'
                                                 'Your request for The following cover has been denied.'
                                                 'You can reach through Our line or reapply for the cover.',
                                           );
                                           // Convert the Mailto instance into a string.
                                           // Use either Dart's string interpolation
                                           // or the toString() method.
                                           await launch('$mailtoLink');
                                           sendEmailDenial(
                                               "${querySnapshot.documents[i]
                                                   .data['Email']}");
                                           SmsSender sender = SmsSender();
                                           String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                           SmsMessage message = SmsMessage(address, 'Greetings,'
                                               'Your request for The following cover has been denied.'
                                               'You can reach through Our line or reapply for the cover.');
                                           message.onStateChanged.listen((state) {
                                             if (state == SmsMessageState.Sent) {
                                               print("SMS is sent!");
                                               setState(() {
                                                 _message = "SMS is sent";
                                               });
                                             } else if (state == SmsMessageState.Delivered) {
                                               print("SMS is delivered!");
                                               setState(() {
                                                 _message = "SMS is delivered!";
                                               });
                                             }
                                           });
                                           sender.sendSms(message);
                                         }, // passing false
                                         child: Text('Denied'),
                                       ),
                                       FlatButton(
                                         onPressed: () {
                                           sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                           SmsSender sender = SmsSender();
                                           String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                           SmsMessage message = SmsMessage(address, 'Greetings,'
                                               'Your Cover Request has been approved and you are required to pay'
                                               ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745');
                                           message.onStateChanged.listen((state) {
                                             if (state == SmsMessageState.Sent) {
                                               print("SMS is sent!");
                                               setState(() {
                                                 _message = "SMS is sent";
                                               });
                                             } else if (state == SmsMessageState.Delivered) {
                                               print("SMS is delivered!");
                                               setState(() {
                                                 _message = "SMS is delivered!";
                                               });
                                             }
                                           });
                                           sender.sendSms(message);
                                         },
                                         child: Text('Approved'),
                                       ),
                                     ],
                                   );
                                 });
                           })
                   ])),
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
     return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "Pension Cover").getDocuments();
   }
 }

class AscomaLife extends StatefulWidget {
  @override
  _AscomaLifeState createState() => _AscomaLifeState();
}

class _AscomaLifeState extends State<AscomaLife> {
  @override
  void initState() {
    super.initState();
    getCoverList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  String _message;
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
                  context, MaterialPageRoute(builder: (context) => AscomaStaff()));
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
                                        onPressed: () async {
                                          final mailtoLink = Mailto(
                                            to: ["${querySnapshot.documents[i]
                                                .data['Email']}"],
                                            cc: ['cc1@example.com', 'cc2@example.com'],
                                            subject: 'Cover request Denial',
                                            body: 'Greetings,'
                                                'Your request for The following cover has been denied.'
                                                'You can reach through Our line or reapply for the cover.',
                                          );
                                          // Convert the Mailto instance into a string.
                                          // Use either Dart's string interpolation
                                          // or the toString() method.
                                          await launch('$mailtoLink');
                                          sendEmailDenial(
                                              "${querySnapshot.documents[i]
                                                  .data['Email']}");
                                          SmsSender sender = SmsSender();
                                          String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                          SmsMessage message = SmsMessage(address, 'Greetings,'
                                              'Your request for The following cover has been denied.'
                                              'You can reach through Our line or reapply for the cover.');
                                          message.onStateChanged.listen((state) {
                                            if (state == SmsMessageState.Sent) {
                                              print("SMS is sent!");
                                              setState(() {
                                                _message = "SMS is sent";
                                              });
                                            } else if (state == SmsMessageState.Delivered) {
                                              print("SMS is delivered!");
                                              setState(() {
                                                _message = "SMS is delivered!";
                                              });
                                            }
                                          });
                                          sender.sendSms(message);
                                        }, // passing false
                                        child: Text('Denied'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          sendEmailApproval("${querySnapshot.documents[i].data['Email']}");
                                          SmsSender sender = SmsSender();
                                          String address = "${querySnapshot.documents[i].data['Phone Number']}";

                                          SmsMessage message = SmsMessage(address, 'Greetings,'
                                              'Your Cover Request has been approved and you are required to pay'
                                              ' the premium via Ecocash 87458 or Lumicash 2106 or In BBCI 0154778745');
                                          message.onStateChanged.listen((state) {
                                            if (state == SmsMessageState.Sent) {
                                              print("SMS is sent!");
                                              setState(() {
                                                _message = "SMS is sent";
                                              });
                                            } else if (state == SmsMessageState.Delivered) {
                                              print("SMS is delivered!");
                                              setState(() {
                                                _message = "SMS is delivered!";
                                              });
                                            }
                                          });
                                          sender.sendSms(message);
                                        },
                                        child: Text('Approved'),
                                      ),
                                    ],
                                  );
                                });
                          })
                  ])),
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
    return await Firestore.instance.collection('Cover').where("Provider", isEqualTo: "ASCOMA").where("Cover",isEqualTo: "Life Cover").getDocuments();
  }
}
