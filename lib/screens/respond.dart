import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/screens/request.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Respond extends StatefulWidget {
  const Respond({Key key}) : super(key: key);

  @override
  _RespondState createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  // List<RequestCard> myList = List<RequestCard>.generate(10, (i) =>
  //     RequestCard(
  //       userName: "Natania",
  //       category: "stationery",
  //       itemName: "Cai png",
  //       quantity: 1,
  //       time: DateTime.now(),
  //     )
  // );

  List<RequestCard> myList = [
    RequestCard(
      userName: "Natania",
      category: "food",
      itemName: "aglio olio",
      quantity: 1,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "stationery",
      itemName: "stapler",
      quantity: 1,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "cleaning",
      itemName: "vacuum cleaner",
      quantity: 1,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "others",
      itemName: "more sleep",
      quantity: 100,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "food",
      itemName: "aglio olio",
      quantity: 1,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "stationery",
      itemName: "stapler",
      quantity: 1,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "cleaning",
      itemName: "vacuum cleaner",
      quantity: 1,
      time: DateTime.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "others",
      itemName: "more sleep",
      quantity: 100,
      time: DateTime.now(),
    ),
  ];



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final user = Provider.of<UserData>(context);
    final userList = Provider.of<List<UserCredentials>>(context);


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UserCredentials>(
          stream: DatabaseService(uid: user.uid).userCredentials,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserCredentials userCredentials = snapshot.data;
              return Container(
                  child: Column(
                    children: <Widget>[
                      // CustomisedAppBar(name: getName(userData).name),
                      // CustomisedAppBar(name: "Natania"),
                      CustomisedAppBar(name: userCredentials.name),
                      ScreenHeader(name: "Respond", withSortBy: true),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              itemCount: myList.length,
                              itemBuilder: (context, index) {
                                return myList[index];
                              }
                          ),
                        ),
                      )
                    ],
                  )
              );
            } else {
              return Loading();
            }
          }
        )
      ),
    );
  }
}
