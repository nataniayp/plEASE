import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:please/components/chatroom_app_bar.dart';
import 'package:please/components/chatBubble.dart';
import 'package:please/services/database.dart';
import 'package:provider/provider.dart';
import 'package:please/models/user_data.dart';
import 'package:please/models/message_data.dart';
import 'package:please/models/chatroom_data.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/shared/loading.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController messageEditingController = new TextEditingController();
  ScrollController messageScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {

    ChatRoomData doc = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserData>(context);

    Widget messageDisplay(){
      return StreamBuilder<List<MessageData>>(
        stream: DatabaseService(chatRoomId: doc.chatRoomId).messageData,
        builder: (context, snapshot){
          if (snapshot.hasData){

            String currentDate;

            // print(chatRoomId);

            List<MessageData> messages = snapshot.data;

            // sort list based on time
            messages.sort((a, b) => a.sendTime.compareTo(b.sendTime));

            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index){
                String formattedDate = DateFormat('dd/MM/yy').format(messages[index].sendTime);
                if (currentDate == null || currentDate != formattedDate) {
                  currentDate = formattedDate;
                  return chatBubble(
                    message: messages[index].message,
                    isSentByUser: messages[index].sendBy == user.uid,
                    sendTime: messages[index].sendTime,
                    showDate: true,
                  );
                } else {
                  return chatBubble(
                    message: messages[index].message,
                    isSentByUser: messages[index].sendBy == user.uid,
                    sendTime: messages[index].sendTime,
                    showDate: false,
                  );
                }
              });
          } else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No messages yet..."),
                ],
              ),
            );
        }
      });
    }

    sendMessage() {
      if (messageEditingController.text.isNotEmpty) {
        Map<String, dynamic> messageMap = {
          "sendBy": user.uid,
          "message": messageEditingController.text,
          "sendTime": DateTime.now(),
        };

        DatabaseService(chatRoomId: doc.chatRoomId).addMessages(messageMap);

        setState(() {
          messageEditingController.text = "";
        });

        messageScrollController.animateTo(
            messageScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    }

    return StreamBuilder<UserCredentials>(
      stream: DatabaseService(uid: user.uid).userCredentials,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  chatRoomAppBar(name: snapshot.data.name == doc.requesterName? doc.responderName: doc.requesterName),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.01,),
                        Expanded(
                          flex: 5,
                          child: messageDisplay(),
                        ),
                        SizedBox(height: size.height * 0.01,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, -10),
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    height: size.height * 0.06,
                                    width: size.width * 0.75,
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 0),
                                    child: TextField(
                                      controller: messageEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type something',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.01),
                                IconButton(
                                    icon: Icon(Icons.send),
                                    color: Colors.teal[900],
                                    onPressed: () {
                                      sendMessage();
                                    }),
                              ],
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
          return Loading();
        }
      }
    );
  }
}
