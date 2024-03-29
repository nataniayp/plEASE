import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/shared/loading.dart';

class ChatRoomAppBar extends StatefulWidget {
  const ChatRoomAppBar({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  _ChatRoomAppBarState createState() => _ChatRoomAppBarState();
}

class _ChatRoomAppBarState extends State<ChatRoomAppBar> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    final user = Provider.of<UserData>(context);

    return StreamBuilder<UserCredentials>(
      stream: DatabaseService(uid: user.uid).userCredentials,
      builder: (context, snapshot){
        if (snapshot.hasData){
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
                            widget.name,
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
        } else {
          return Loading();
        }
      }
    );
  }
}
