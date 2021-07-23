import 'package:flutter/material.dart';
import 'package:please/models/request_item.dart';

class ScreenHeader extends StatefulWidget {
  const ScreenHeader({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(0.045 * size.height),
      child: Row(
        children: <Widget>[
          Text(
            widget.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 0.02 * size.height,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}