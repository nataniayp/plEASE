import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/screens/request_input.dart';

class Request extends StatefulWidget {
  const Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
            child: Column(
              children: <Widget>[
                CustomisedAppBar(name: "Natania"),
              ],
            )
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Request'),
              SizedBox(height: 50.0),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                        border: Border.all(width: 5.0, color: Colors.teal[900])
                    ),
                    height: 200.0,
                    width: 200.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/request');
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fastfood,
                              size: 150,
                            ),
                            SizedBox(height: 10.0),
                            Text('Food'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                        border: Border.all(width: 5.0, color: Colors.teal[900])
                    ),
                    height: 200.0,
                    width: 200.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/request');
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.square_foot,
                              size: 150,
                            ),
                            SizedBox(height: 10.0),
                            Text('Stationery'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200],
                      border: Border.all(width: 5.0, color: Colors.teal[900])
                    ),
                    height: 200.0,
                    width: 200.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/request');
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/sweeping.png',
                              height: 150.0,
                              width: 150.0,
                            ),
                            SizedBox(height: 10.0),
                            Text('Cleaning supplies'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[200],
                        border: Border.all(width: 5.0, color: Colors.teal[900])
                    ),
                    height: 200.0,
                    width: 200.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/request');
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/audio-jack.png',
                              height: 150.0,
                              width: 150.0,
                            ),
                            SizedBox(height: 10.0),
                            Text('Others'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
