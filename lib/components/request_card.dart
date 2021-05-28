import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RequestCard extends StatefulWidget {
  RequestCard({
    Key key,
    @required this.userName,
    @required this.category,
    @required this.itemName,
    @required this.quantity,
    @required this.selectedDate,
    @required this.selectedTime,
  }) : super(key: key);

  final String userName;
  final String category;
  final String itemName;
  final int quantity;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  bool accepted = false;
  String acceptedBy;
  String acceptedByUid;

  void reqAccepted(String acceptedBy, String acceptedByUid) {
    this.accepted = true;
    this.acceptedBy = acceptedBy;
    this.acceptedByUid = acceptedByUid;
  }


  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    String formatTimeOfDay(TimeOfDay tod) {
      final now = new DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
      final format = DateFormat.jm();
      return format.format(dt);
    }

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
                'assets/icons/${widget.category}.png',
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
                Expanded(
                  child: Text(
                    "${widget.userName} wants"
                  ),
                ),
                Expanded(
                  child: Text(
                    "${widget.itemName} (${widget.quantity})",
                    style: TextStyle(
                      color: Colors.teal[900],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "by ${DateFormat('EEE, d/M/y,').format(widget.selectedDate)} ${formatTimeOfDay(widget.selectedTime)}"
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/respond_details', );
              },
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
