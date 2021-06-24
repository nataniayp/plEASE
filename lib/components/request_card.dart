import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:please/screens/chatroom.dart';


class RequestCard extends StatefulWidget {
  RequestCard({
    Key key,
    @required this.uid,
    @required this.userName,
    @required this.category,
    @required this.itemName,
    @required this.quantity,
    @required this.selectedDate,
    @required this.selectedTime,
    this.accepted,
    this.acceptedBy,
    this.acceptedByUid,
    this.routeToChatRoom,
  }) : super(key: key);

  String uid;
  String userName;
  String category;
  String itemName;
  int quantity;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  bool accepted = false;
  String acceptedBy;
  String acceptedByUid;
  bool routeToChatRoom;

  void reqAccepted(String acceptedBy, String acceptedByUid) {
    this.accepted = true;
    this.acceptedBy = acceptedBy;
    this.acceptedByUid = acceptedByUid;
  }

  RequestCard.empty();

  bool isEmpty() {
    return this.uid == null;
  }

  int compareTOD(TimeOfDay a, TimeOfDay b) {
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;
    return toDouble(a).compareTo(toDouble(b));
  }

  bool isExpired() {
    int val = this.selectedDate.compareTo(DateTime.now());
    String dateRequest = this.selectedDate.toString().substring(0, this.selectedDate.toString().indexOf(' '));
    String dateCurrent = DateTime.now().toString().substring(0, DateTime.now().toString().indexOf(' '));
    if (val < 0 && dateRequest != dateCurrent) {
      return true;
    } else if (val < 0) {
      return compareTOD(this.selectedTime, TimeOfDay.now()) < 0;
    } else {
      return false;
    }
  }


  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    RequestCard rc = RequestCard(
      uid: widget.uid,
      userName: widget.userName,
      category: widget.category,
      itemName: widget.itemName,
      quantity: widget.quantity,
      selectedDate: widget.selectedDate,
      selectedTime: widget.selectedTime,
    );
    
    String formatTimeOfDay(TimeOfDay tod) {
      final now = new DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
      final format = DateFormat.jm();
      return format.format(dt);
    }

    if (!widget.isEmpty()) {
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
        child: FlatButton(
          onPressed: widget.routeToChatRoom?
              () async {
                await Navigator.pushNamed(context, '/chatroom', arguments: '${widget.uid}_${widget.acceptedByUid}');
              }:
              () async {
                await Navigator.pushNamed(context, '/respond_details', arguments: rc);
              },
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
                          "by ${DateFormat('EEE, d/M/y,').format(widget.selectedDate)} ${widget.selectedTime.format(context)}",
                        style: TextStyle(
                          color: widget.accepted
                              ? Colors.teal[700]
                              : widget.isExpired()
                                ? Colors.red[900]
                                : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }

  }
}
