import 'package:flutter/material.dart';
import 'package:please/screens/home.dart';
import 'package:please/screens/request_input.dart';
import 'package:please/screens/my_requests.dart';
import 'package:please/screens/my_responses.dart';
import 'package:please/screens/respond_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Please',
      routes: {
        '/': (context) => Home(),
        '/my_requests': (context) => MyRequests(),
        '/request_input': (context) => RequestInput(),
        '/my_responses': (context) => MyResponses(),
        '/respond_details': (context) => RespondDetails(),
        // '/profile': (context) => Profile(),
      },
    );
  }
}