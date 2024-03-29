import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/models/request_item.dart';
import 'package:please/components/screen_header.dart';

class Request extends StatefulWidget {
  const Request({Key key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  String category;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomisedAppBar(),
            ScreenHeader(name: 'Request'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container( // Food
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                            ),
                          color: Color(0xfff0f0eb),
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 4,
                          //     color: Colors.grey.withOpacity(0.4),
                          //     offset: Offset(0, 8), // changes position of shadow
                          //   ),
                          // ]
                        ),
                        height: size.height * 0.22,
                        width: size.height * 0.22,
                        child: FlatButton(
                          onPressed: () {
                            category = 'Food';
                            Navigator.pushNamed(context, '/request_input', arguments: category);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.05, size.width * 0.05, 0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/food.png',
                                  color: Color(0xff3a4a51),
                                  scale: 8,
                                ),
                                SizedBox(height: size.height * 0.03),
                                Text(
                                  'Food',
                                  style: TextStyle(
                                    color: Color(0xff3a4a51),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),

                            color: Color(0xfff0f0eb),
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 4,
                          //     color: Colors.grey.withOpacity(0.4),
                          //     offset: Offset(0, 8), // changes position of shadow
                          //   ),
                          // ]
                        ),
                        height: size.height * 0.22,
                        width: size.height * 0.22,
                        child: FlatButton(
                          onPressed: () {
                            category = 'Stationery';
                            Navigator.pushNamed(context, '/request_input', arguments: category);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/stationery.png',
                                  color: Color(0xff3a4a51),
                                  scale: 8,
                                ),
                                SizedBox(height: size.height * 0.03),
                                Text(
                                  'Stationery',
                                  style: TextStyle(
                                    color: Color(0xff3a4a51),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color(0xfff0f0eb),
                            // boxShadow: [
                            //   BoxShadow(
                            //     blurRadius: 4,
                            //     color: Colors.grey.withOpacity(0.4),
                            //     offset: Offset(0, 8), // changes position of shadow
                            //   ),
                            // ]
                        ),
                        height: size.height * 0.22,
                        width: size.height * 0.22,
                        child: FlatButton(
                          onPressed: () {
                            category = 'Cleaning supplies';
                            Navigator.pushNamed(context, '/request_input', arguments: category);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/cleaning.png',
                                  color: Color(0xff3a4a51),
                                  scale: 8,
                                ),
                                SizedBox(height: size.height * 0.03),
                                Text(
                                  'Cleaning supplies',
                                  style: TextStyle(
                                    color: Color(0xff3a4a51),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                            ),
                            // color: Colors.white,
                            color: Color(0xfff0f0eb),
                            // boxShadow: [
                            //   BoxShadow(
                            //     blurRadius: 4,
                            //     color: Colors.grey.withOpacity(0.4),
                            //     offset: Offset(0, 8), // changes position of shadow
                            //   ),
                            // ]
                        ),
                        height: size.height * 0.22,
                        width: size.height * 0.22,
                        child: FlatButton(
                          onPressed: () {
                            category = 'Others';
                            Navigator.pushNamed(context, '/request_input', arguments: category);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/audio-jack.png',
                                  color: Color(0xff3a4a51),
                                  scale: 8,
                                ),
                                SizedBox(height: size.height * 0.03),
                                Text(
                                  'Others',
                                  style: TextStyle(
                                    color: Color(0xff3a4a51),
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
