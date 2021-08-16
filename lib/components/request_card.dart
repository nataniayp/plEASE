import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:please/models/chatroom_data.dart';
import 'package:please/models/request_item.dart';


class RequestCard extends StatefulWidget {

  RequestCard({
    Key key,
    @required this.rq,
    this.routeToChatRoom,
  }) : super(key: key);

  // RequestCard({
  //   Key key,
  //   @required this.uid,
  //   @required this.userName,
  //   @required this.category,
  //   @required this.itemName,
  //   @required this.quantity,
  //   @required this.selectedDate,
  //   @required this.selectedTime,
  //   this.accepted,
  //   this.acceptedBy,
  //   this.acceptedByUid,
  //   this.routeToChatRoom,
  // }) : super(key: key);

  final RequestItem rq;
  final bool routeToChatRoom;

  bool isEmpty() {
    return this.rq.uid == null;
  }


  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (!widget.isEmpty()) {
      return Container(
        height: 0.105 * size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
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
          onPressed: widget.rq.accepted && widget.routeToChatRoom?
              () async {
                await Navigator.pushNamed(context, '/chatroom', arguments: ChatRoomData(
                  chatRoomId: '${widget.rq.uid}_${widget.rq.acceptedByUid}',
                  requesterName: widget.rq.userName,
                  responderName: widget.rq.acceptedBy,
                ));
              }:
              () async {
                await Navigator.pushNamed(context, '/respond_details', arguments: widget.rq);
              },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(0.01 * size.height),
                  child: Image.asset(
                    'assets/icons/${widget.rq.category}.png',
                    color: Color(0xff3a4a51),
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
                          "${widget.rq.userName} wants"
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${widget.rq.itemName} (${widget.rq.quantity})",
                        style: TextStyle(
                          color: Colors.teal[900],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                          "by ${DateFormat('EEE, d/M/y,').format(widget.rq.date)} ${widget.rq.time.format(context)}",
                        style: TextStyle(
                          color: widget.rq.accepted
                              ? Colors.teal[700]
                              : widget.rq.isExpired()
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
