import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/request_item.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key key}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

  RequestItem selected;

  List<RequestCard> myList = [
    RequestCard(
      userName: "Natania",
      category: "food",
      itemName: "aglio olio",
      quantity: 1,
      time: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    selected = ModalRoute.of(context).settings.arguments;
    if (selected != null) myList.add(new RequestCard(
      userName: selected.id, 
      category: selected.category,
      itemName: selected.itemName,
      quantity: selected.quantity,
      time: selected.date,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            CustomisedAppBar(name: 'Natania'),
            ScreenHeader(name: 'My Requests', withAdd: true,),
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
