import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/screens/request.dart';
import 'package:please/services/database.dart';
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

  String getCurrentUser() {
    User user = FirebaseAuth.instance.currentUser;
    return user.uid;
  }

  UserCredentials getName(List<UserCredentials> list) {
    UserCredentials curr;
    for (UserCredentials u in list) {
      if (u.uid == getCurrentUser()) {
        curr = u;
        break;
      }
    }
    return curr;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final userData = Provider.of<List<UserCredentials>>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              CustomisedAppBar(name: getName(userData).name),
              // CustomisedAppBar(name: getName(userData)[0].name),
              // CustomisedAppBar(name: userData[0].uid),
              // CustomisedAppBar(name: "Natania"),
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
        )
      ),
    );
  }
}
