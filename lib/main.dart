import 'package:flutter/material.dart';
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
        '/': (context) => Profile(),
        // '/request': (context) => Request(),
        // '/respond': (context) => Respond(),
      },
    );
  }
}