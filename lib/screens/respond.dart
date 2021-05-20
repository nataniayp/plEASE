import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/screen_header.dart';





class Respond extends StatefulWidget {
  const Respond({Key key}) : super(key: key);

  @override
  _RespondState createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  List<RequestCard> myList = List<RequestCard>.generate(10, (i) =>
      RequestCard(
        userName: "Natania",
        category: "Food",
        itemName: "Cai png",
        quantity: 1,
        time: DateTime.now(),
      )
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              CustomisedAppBar(name: "Natania"),
              ScreenHeader(name: "Respond", withSortBy: true),
              Expanded(
                child: ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    return myList[index];
                  }
                ),
              )
            ],
          )
        )
      ),
    );
  }
}
