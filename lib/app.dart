import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'category.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assurance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Assurance'),
      initialRoute: '/login',
      onGenerateRoute: _getLogin,
    );
  }
}

Route<dynamic> _getLogin(RouteSettings settings) {
  return MaterialPageRoute<void>(
    builder: (BuildContext context) => Login(),
  );
}