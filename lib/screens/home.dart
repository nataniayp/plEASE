import 'package:flutter/material.dart';
import 'package:please/screens/request.dart';
import 'package:please/screens/respond.dart';
import 'package:please/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Request(),
    Respond(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/interview.png',
              color: Colors.teal[900],
              height: 23,
            ),
            label: "Respond",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/reply.png',
              color: Colors.teal[900],
              height: 23,
            ),
            label: "Request",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/user.png',
              color: Colors.teal[900],
              height: 23,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

