import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';

class Request extends StatefulWidget {
  const Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
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
