import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:please/screens/request_input.dart';
import 'package:please/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:please/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:please/models/user_data.dart';


void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Please',
        home: Wrapper(),
        routes: {
          // '/': (context) => Home(),
          '/request': (context) => RequestInput(),
          // '/request': (context) => Request(),
          // '/respond': (context) => Respond(),
          // '/profile': (context) => Profile(),
        },
      ),
    );
  }
}