import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Container(
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
                  height: 0.0125 * size.height,
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
                  height: 0.1 * size.height,
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
    );
  }
}