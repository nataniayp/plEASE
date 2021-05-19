import 'package:flutter/material.dart';

class CustomisedAppBar extends StatefulWidget {
  const CustomisedAppBar({Key key, @required this.name}) : super(key: key);

  final String name;

  @override
  _CustomisedAppBarState createState() => _CustomisedAppBarState();
}

class _CustomisedAppBarState extends State<CustomisedAppBar> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.23,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal[900], Colors.grey[600]]
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.25),
                ),
              ]
            ),
          ),
          Positioned(
            top: size.height * 0.06,
            left: size.height * 0.06,
            child: Text(
              "Hello,\n${widget.name}",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.042,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
