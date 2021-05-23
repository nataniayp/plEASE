import 'package:flutter/material.dart';

class ScreenHeader extends StatefulWidget {
  const ScreenHeader({
    Key key,
    @required this.name,
    this.withSortBy,
    this.withAdd,
  }) : super(key: key);

  final String name;
  final bool withSortBy;
  final bool withAdd;

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
         Spacer(),
         if (widget.withSortBy != null && widget.withSortBy)
           TextButton(
             onPressed: () {},
             child: Text(
               "SORT BY",
               style: TextStyle(
                 color: Colors.teal[900],
                 fontWeight: FontWeight.bold,
                 fontSize: 0.02 * size.height,
                 letterSpacing: 1.0,
               ),
             ),
           ),
          if (widget.withAdd != null && widget.withAdd)
            TextButton(
              onPressed: () {},
              child: Text(
                "+",
                style: TextStyle(
                  color: Colors.teal[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 0.02 * size.height,
                  letterSpacing: 1.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
