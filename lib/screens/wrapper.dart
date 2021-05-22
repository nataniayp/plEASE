import 'package:flutter/material.dart';
import 'package:please/screens/home.dart';
import 'package:please/models/user.dart';
import 'package:provider/provider.dart';
import 'package:please/screens/authenticate/authenticate.dart';
import 'package:please/screens/authenticate/sign_in.dart';
import 'package:please/screens/authenticate/register.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
