import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';

class Request extends StatefulWidget {
  const Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomisedAppBar(),
              ScreenHeader(name: 'Request'),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
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
                        color: Colors.white,
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
                      color: Colors.white,
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
                        color: Colors.white,
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
              SizedBox(height: 20.0),
              FlatButton(
                onPressed: () {},
                color: Colors.teal[900],
                height: 50.0,
                minWidth: 300.0,
                child: Text(
                  'My Requests',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
