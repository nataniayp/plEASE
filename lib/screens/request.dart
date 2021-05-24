import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_item.dart';
import 'package:please/components/screen_header.dart';

class Request extends StatefulWidget {
  const Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {

  RequestItem selected = new RequestItem(id: 'Natatnia');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomisedAppBar(name: 'Natania'),
            ScreenHeader(name: 'Request'),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container( // Food
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(0, 8), // changes position of shadow
                      ),
                    ]
                  ),
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  child: FlatButton(
                    onPressed: () {
                      selected.category = 'Food';
                      Navigator.pushReplacementNamed(context, '/request_input', arguments: selected);
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'icons/food.png',
                            color: Colors.teal[900],
                            scale: 0.8,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Text(
                            'Food',
                            style: TextStyle(
                              color: Colors.teal[900],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.08),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 8), // changes position of shadow
                        ),
                      ]
                  ),
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  child: FlatButton(
                    onPressed: () {
                      selected.category = 'Stationery';
                      Navigator.pushReplacementNamed(context, '/request_input', arguments: selected);
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'icons/stationery.png',
                            color: Colors.teal[900],
                            scale: 0.8,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Text(
                            'Stationery',
                            style: TextStyle(
                              color: Colors.teal[900],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.width * 0.08),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 8), // changes position of shadow
                        ),
                      ]
                  ),
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  child: FlatButton(
                    onPressed: () {
                      selected.category = 'Cleaning supplies';
                      Navigator.pushReplacementNamed(context, '/request_input', arguments: selected);
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'icons/cleaning.png',
                            color: Colors.teal[900],
                            scale: 8,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Text(
                            'Cleaning supplies',
                            style: TextStyle(
                              color: Colors.teal[900],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.08),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 8), // changes position of shadow
                        ),
                      ]
                  ),
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  child: FlatButton(
                    onPressed: () {
                      selected.category = 'Others';
                      Navigator.pushReplacementNamed(context, '/request_input', arguments: selected);
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'icons/audio-jack.png',
                            color: Colors.teal[900],
                            scale: 8,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Text(
                            'Others',
                            style: TextStyle(
                              color: Colors.teal[900],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              child: Text(
                'MY REQUESTS',
                style: TextStyle(
                  color: Colors.teal[900],
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
