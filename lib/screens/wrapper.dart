import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:please/screens/authenticate/verify.dart';
import 'package:please/screens/home.dart';
import 'package:please/models/user_data.dart';
import 'package:provider/provider.dart';
import 'package:please/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    // return either Home, Verify or Authenticate widget
    if (user != null && !FirebaseAuth.instance.currentUser.emailVerified) {
      return Verify();
    } else if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
