import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'category.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assurance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //stream: FirebaseAuth.instance.onAuthStateChanged,
      home: MyHomePage(title: 'Assurance'),
      initialRoute: '/login',
      onGenerateRoute: _getLogin,
    );
  }
}

Route<dynamic> _getLogin(RouteSettings settings) {
  return MaterialPageRoute<void>(
    builder: (BuildContext context) => Landing(),
  );
}

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return Login();
          }
          return MyHomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
