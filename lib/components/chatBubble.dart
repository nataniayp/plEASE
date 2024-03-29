import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key key,
    @required this.message,
    @required this.isSentByUser,
    @required this.sendTime,
    @required this.showDate,
  }) : super(key: key);

  final String message;
  final bool isSentByUser;
  final DateTime sendTime;
  final bool showDate;

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    // print(widget.sendTime);

    String formattedDate = DateFormat('dd/MM/yy').format(widget.sendTime);
    String formattedTime = DateFormat('kk:mm').format(widget.sendTime);

    return Column(
      children: [
        widget.showDate? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius:
                  BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 12
                  ),
                ),
              ),
            ),
          ],
        ): SizedBox(),
        Container(
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
                        formattedTime,
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
        ),
      ],
    );
  }
}