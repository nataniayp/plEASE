import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';

class Respond extends StatefulWidget {
  const Respond({Key key}) : super(key: key);

  @override
  _RespondState createState() => _RespondState();
}

class _RespondState extends State<Respond> {

  List<RequestCard> myList = [
    RequestCard(
      userName: "Natania",
      category: "food",
      itemName: "aglio olio",
      quantity: 1,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "stationery",
      itemName: "stapler",
      quantity: 1,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "cleaning",
      itemName: "vacuum cleaner",
      quantity: 1,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "others",
      itemName: "more sleep",
      quantity: 100,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "food",
      itemName: "aglio olio",
      quantity: 1,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "stationery",
      itemName: "stapler",
      quantity: 1,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "cleaning",
      itemName: "vacuum cleaner",
      quantity: 1,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
    RequestCard(
      userName: "Natania",
      category: "others",
      itemName: "more sleep",
      quantity: 100,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    ),
  ];

  RequestCard convertMapToRequestCard(Map<String, dynamic> map) {
    return RequestCard(
      userName: map['name'],
      category: map['cat'],
      itemName: map['item'],
      quantity: map['quantity'],
      selectedDate: DateTime.parse(map['date']),
      selectedTime: TimeOfDay(hour: int.parse(map['time'].split(":")[0]), minute: int.parse(map['time'].split(":")[1])),
    );
  }

  List<RequestCard> convertList(List<dynamic> myList) {
    return myList.map((item) => convertMapToRequestCard(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // to get current uid
    final user = Provider.of<UserData>(context);

    // to get userList
    // final userList = Provider.of<List<UserCredentials>>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<UserCredentials>>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserCredentials> userData = snapshot.data;
              return Container(
                  child: Column(
                    children: <Widget>[
                      CustomisedAppBar(),
                      ScreenHeader(name: "Respond", withSortBy: true),
                      // convertMapToRequestCard(userData[0].req[0]),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              itemCount: convertList(userData[0].req).length,
                              itemBuilder: (context, index) {
                                return convertList(userData[0].req)[index];
                              }
                          ),
                        ),
                      )
                    ],
                  )
              );
            } else {
              print(snapshot.error);
              return Loading();
            }
          }
        )
      ),
    );
  }
}
