import 'package:flutter/material.dart';
import 'package:please/screens/home.dart';
import 'package:please/screens/request.dart';
import 'package:please/screens/respond.dart';
import 'package:please/screens/profile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Please',
      routes: {
        '/': (context) => Home(),
        '/request': (context) => Request(),
        '/profile': (context) => Profile(),
        '/respond': (context) => Respond(),
      },
    );
  }
}