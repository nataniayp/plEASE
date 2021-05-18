import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal[900], Colors.grey[600]]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 200.0,
                bottom: 150.0),
            child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 200.0,
                  // ),
                  CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0,
                        vertical: 20.0),
                    child: Divider(
                      height: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                        '3 requests',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                        '5 responses',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 130.0,
                  ),
                  TextButton(
                    onPressed: () {},
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