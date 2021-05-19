import 'package:flutter/material.dart';
import 'package:please/screens/home.dart';
import 'package:please/screens/request_input.dart';


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
        '/request': (context) => RequestInput(),
        // '/request': (context) => Request(),
        // '/respond': (context) => Respond(),
        // '/profile': (context) => Profile(),
      },
    );
  }
}