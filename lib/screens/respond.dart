import 'package:flutter/material.dart';

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
          child: Container()
      ),
    );
  }
}
