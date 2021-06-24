import 'package:flutter/material.dart';

class chatRoomAppBar extends StatefulWidget {
  const chatRoomAppBar({Key key}) : super(key: key);

  @override
  _chatRoomAppBarState createState() => _chatRoomAppBarState();
}

class _chatRoomAppBarState extends State<chatRoomAppBar> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.12,
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
                  child: FlatButton(
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Text(
                      "User",
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
