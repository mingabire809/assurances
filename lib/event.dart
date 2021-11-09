import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const Text('Loading Data...'));
        }
        return GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Card(
                child: Column(
                  children: <Widget>[
                    Image.network(snapshot.data.documents[index]['Image Url'],
                        fit: BoxFit.cover, width: 190, height: 179),
                    Text(snapshot.data.documents[index]['Full name']),
                  ],
                ),
              ),
              onTap: () async {
                var url = snapshot.data.documents[index]['Image Url'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            );
          },
          itemCount: snapshot.data.documents.length,
        );

      },
    );
  }
}
