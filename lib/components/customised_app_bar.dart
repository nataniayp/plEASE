import 'package:flutter/material.dart';

class CustomisedAppBar extends StatefulWidget {
  const CustomisedAppBar({
    Key key,
    @required this.name,
    this.withBackArrow,
  }) : super(key: key);

  final String name;
  final bool withBackArrow;

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
              ],
            ),
          ),
          Align(
            // padding: EdgeInsets.only(
            alignment: Alignment.center,
            // ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: (widget.withBackArrow != null
                      && widget.withBackArrow) ? FlatButton(
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ) : Text(""),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
