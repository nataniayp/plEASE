import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:please/controller/respond_details_controller.dart';
import 'package:provider/provider.dart';
import 'package:please/models/request_item.dart';

class RespondDetails extends StatefulWidget {
  const RespondDetails({Key key}) : super(key: key);

  @override
  _RespondDetailsState createState() => _RespondDetailsState();
}

class _RespondDetailsState extends State<RespondDetails> {


  
  @override
  Widget build(BuildContext context) {
    RespondDetailsController con = RespondDetailsController();
    Size size = MediaQuery.of(context).size;
    RequestItem req = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<UserData>(context);

    List<String> users = [req.uid, user.uid];
    String chatRoomId = "${req.uid}_${user.uid}";
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UserCredentials>(
          stream: DatabaseService(uid: user.uid).userCredentials,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomisedAppBar(withBackArrow: true,),
                  ScreenHeader(name: 'Respond Details'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/${req.category}.png',
                        color: Colors.teal[900],
                        height: 0.1 * size.height,
                      ),
                      SizedBox(width: 0.05 * size.width),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${req.itemName.toUpperCase()}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Text(
                            'quantity: ${req.quantity}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Text(
                            'requested by ${req.userName}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Text(
                            'to be ready by',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Text(
                            '${req.getDateInStringWithDay()} ${req.getTimeInString()}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 0.02 * size.height),
                  StreamBuilder<List<String>>(
                      stream: DatabaseService(uid: user.uid).getTokenIds(req.uid),
                      builder: (context, snapshotToken) {
                        if (snapshotToken.hasData) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
                            child: FlatButton(
                              // TODO change routing to chatroom
                              onPressed: user.uid == req.uid? null: () async {
                                await con.acceptRequest(
                                  req,
                                  user.uid,
                                  snapshot.data.name,
                                  snapshot.data.uid,
                                  snapshotToken.data,
                                  chatRoomId,
                                  chatRoomMap
                                );
                                await Navigator.pushReplacementNamed(context, '/my_responses');
                              },
                              color: Colors.white,
                              height: 50.0,
                              minWidth: 200.0,
                              child: Text(
                                'ACCEPT',
                                style: TextStyle(
                                  color: user.uid == req.uid ? Colors.grey[500]: Colors.teal[900],
                                  letterSpacing: 1.7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }
                        return Loading();
                      }
                  ),

                  (user.uid == req.uid)
                    ? FlatButton(
                      onPressed: () async {
                        await con.deleteRequest(req, user.uid);
                        Navigator.pop(context);
                      },
                      height: 50.0,
                      minWidth: 200.0,
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                          color: Colors.teal[900],
                          letterSpacing: 1.7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) : Container()
                ],
              );
            } else {
              return Loading();
            }
          }
        ),
      ),
    );
  }
}

