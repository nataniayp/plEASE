import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class chatBubble extends StatefulWidget {
  const chatBubble({
    Key key,
    @required this.message,
    @required this.isSentByUser,
    @required this.sendTime,
  }) : super(key: key);

  final String message;
  final bool isSentByUser;
  final DateTime sendTime;

  @override
  _chatBubbleState createState() => _chatBubbleState();
}

class _chatBubbleState extends State<chatBubble> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    String formattedDate = DateFormat('kk:mm').format(widget.sendTime);

    return Container(
      margin: widget.isSentByUser?
      EdgeInsets.fromLTRB(size.width * 0.5, size.height * 0.01, size.width * 0.04, size.height * 0.01):
      EdgeInsets.fromLTRB(size.width * 0.04, size.height * 0.01, size.width * 0.5, size.height * 0.01),
      width: size.width,
      alignment: widget.isSentByUser? Alignment.centerRight: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.03),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: widget.isSentByUser?
          BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ) :
          BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${widget.message}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    formattedDate,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}