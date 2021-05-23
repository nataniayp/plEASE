import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/components/request_card.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key key}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              CustomisedAppBar(name: 'Natania', withBackArrow: true,),
              ScreenHeader(name: 'My Requests', withSortBy: true,),
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
          ),
        ),
      ),
    );
  }
}
