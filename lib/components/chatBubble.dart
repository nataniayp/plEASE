import 'package:flutter/material.dart';

class chatBubble extends StatefulWidget {
  const chatBubble({
    Key key,
    @required this.message,
    @required this.isSentByUser,
  }) : super(key: key);

  final String message;
  final bool isSentByUser;

  @override
  _chatBubbleState createState() => _chatBubbleState();
}

class _chatBubbleState extends State<chatBubble> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(size.width * 0.04, size.height * 0.02, size.width * 0.04, 0),
      width: size.width,
      alignment: widget.isSentByUser? Alignment.centerRight: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.04),
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
        child: Text(
          '${widget.message}',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}