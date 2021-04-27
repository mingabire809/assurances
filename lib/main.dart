import 'package:assurance/locat.dart';
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await setupLocat();
  runApp(MyApp());
}


