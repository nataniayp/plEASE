import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';

class Respond extends StatefulWidget {
  const Respond({Key key}) : super(key: key);

  @override
  _RespondState createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[

            ],
          )
        )
      ),
    );
  }
}
