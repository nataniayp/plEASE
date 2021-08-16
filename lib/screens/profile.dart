import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:please/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xff4a675a), const Color(0xff3a4a51)]
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.2 * size.height,
                // bottom: 0.1 * size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icons/logo.png',
                  color: Colors.grey[200],
                  height: 0.2 * size.height,
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
                SizedBox(
                  height: 0.04 * size.height,
                ),
                Container(
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    // color: Colors.grey[500],
                    color: const Color(0xd9ACB5A0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.7,
                        )
                    ),
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