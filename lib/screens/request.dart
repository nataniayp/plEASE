import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Container()
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/interview.png',
              color: Colors.teal[900],
              height: 23,
            ),
            label: "Respond",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/reply.png',
              color: Colors.teal[900],
              height: 23,
            ),
            label: "Request",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/user.png',
              color: Colors.teal[900],
              height: 23,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
