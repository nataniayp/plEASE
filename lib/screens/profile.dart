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