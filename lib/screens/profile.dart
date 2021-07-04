import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:please/services/auth.dart';
import 'package:http/http.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  Future<Response> sendNotification(List<String> tokenIdList, String contents, String heading) async{

    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": '729732d6-6359-40bb-8847-ca6e0c987d25',//kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color":"FF9976D2",

        "small_icon":"ic_stat_onesignal_default",

        "large_icon":"https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

        "headings": {"en": heading},

        "contents": {"en": contents},


      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[900], Colors.grey[600]]
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.25 * size.height,
                // bottom: 0.1 * size.height,
            ),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 0.1 * size.height,
                  backgroundColor: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.25 * size.width,
                      vertical: 0.025 * size.height,
                  ),
                  child: Divider(
                    // height: 0.025 * size.height,
                    indent: 0.02 * size.width,
                    endIndent: 0.02 * size.width,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/my_requests');
                  },
                  child: Text(
                      'My Requests',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                      )
                  ),
                ),
                // SizedBox(
                //   height: 0.002 * size.height,
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/my_responses');
                  },
                  child: Text(
                      'My Responses',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                      )
                  ),
                ),
                TextButton(
                  onPressed: () {
                    sendNotification(['31ea5c49-3c14-4b2f-a93e-9a592e901b9b'], 'Your request has been accepted!', 'plEASE');
                  },
                  child: Text('Send notification'),
                ),
                SizedBox(
                  height: 0.1 * size.height,
                ),
                TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                    print(FirebaseAuth.instance.currentUser);
                  },
                  child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.grey[500],
                        letterSpacing: 1.7,
                      )
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}