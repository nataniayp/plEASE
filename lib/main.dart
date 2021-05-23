import 'package:flutter/material.dart';
import 'package:please/screens/home.dart';
import 'package:please/screens/request_input.dart';
import 'package:please/screens/my_requests.dart';

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
        '/my_requests': (context) => MyRequests(),
        // '/request': (context) => Request(),
        // '/respond': (context) => Respond(),
        // '/profile': (context) => Profile(),
      },
    );
  }
}