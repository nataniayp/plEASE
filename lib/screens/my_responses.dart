import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/components/request_card.dart';

class MyResponses extends StatefulWidget {
  const MyResponses({Key key}) : super(key: key);

  @override
  _MyResponsesState createState() => _MyResponsesState();
}

class _MyResponsesState extends State<MyResponses> {

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
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomisedAppBar(withBackArrow: true,),
            ScreenHeader(name: 'My Responses'),
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
    );
  }
}
