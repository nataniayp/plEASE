import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RequestCard extends StatefulWidget {
  const RequestCard({
    Key key,
    @required this.userName,
    @required this.category,
    @required this.itemName,
    @required this.quantity,
    @required this.time,
  }) : super(key: key);

  final String userName;
  final String category;
  final String itemName;
  final int quantity;
  final DateTime time;


  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 0.105 * size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ]
      ),
      padding: EdgeInsets.only(
        top: 0.02 * size.height,
        bottom: 0.02 * size.height,
      ),
      margin: EdgeInsets.only(
        left: 0.1 * size.width,
        right: 0.1 * size.width,
        bottom: 0.02 * size.height,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(0.01 * size.height),
              child: Image.asset(
                'icons/${widget.category}.png',
                color: Colors.teal[900],
              ),
            ),
            // child: Icon(
            //   Icons.fastfood,
            // ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${widget.userName} wants"
                ),
                Text(
                  "${widget.itemName} (${widget.quantity})",
                  style: TextStyle(
                    color: Colors.teal[900],
                  ),
                ),
                Text(
                  "by ${DateFormat('EEE, d/M/y, HH:mm').format(widget.time)}",
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.navigate_next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
