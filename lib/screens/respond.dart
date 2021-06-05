import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  String currentCat = "FILTER";
  List<String> category = ['FILTER', 'Food', 'Stationery', 'Cleaning', 'Others'];

  String convertCatName(String s) {
    if (s == 'Food') {
      return 'food';
    } else if (s == 'Stationery') {
      return 'stationery';
    } if (s == 'Cleaning') {
      return 'cleaning';
    } else if (s == 'Others') {
      return 'others';
    } else {
      return 'FILTER';
    }
  }

  TimeOfDay convertStringToTimeOfDay(String t) {
    int hour;
    int minute;
    String ampm = t.substring(t.length - 2);
    String result = t.substring(0, t.indexOf(' '));
    if (ampm == 'AM' && int.parse(result.split(":")[0]) != 12) {
      hour = int.parse(result.split(':')[0]);
      if (hour == 12) hour = 0;
      minute = int.parse(result.split(":")[1]);
    } else {
      hour = int.parse(result.split(':')[0]) - 12;
      if (hour <= 0) {
        hour = 24 + hour;
      }
      minute = int.parse(result.split(":")[1]);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  RequestCard convertMapToRequestCard(Map<String, dynamic> map) {
    return RequestCard(
      uid: map['uid'],
      userName: map['name'],
      category: map['cat'],
      itemName: map['item'],
      quantity: map['quantity'],
      selectedDate: DateTime.parse(map['date']),
      selectedTime: convertStringToTimeOfDay(map['time']),
      accepted: map['accepted'],
      acceptedBy: map['acceptedBy'],
      acceptedByUid: map['acceptedByUid'],
    );
  }

  List<RequestCard> flatMap(List<List<RequestCard>> l) {
    List<RequestCard> result = [];
    for (List<RequestCard> m in l) {
      result.addAll(m);
    }
    return result;
  }

  List<RequestCard> convertList(List<dynamic> myList) {
    return myList.map((item) => (
        (item["accepted"] as bool) ? RequestCard.empty(): convertMapToRequestCard(item))).toList();
  }

  List<RequestCard> filterList(List<RequestCard> l, String s) {
    if (s == 'FILTER') {
      return l;
    } else {
      return l
          .where((item) => item.category == convertCatName(s))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // to get current uid
    final user = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<UserCredentials>>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserCredentials> userData = snapshot.data;

              List<RequestCard> finalList = filterList(flatMap(
                  userData.map((item) => convertList(item.reqList).toList()).toList()), currentCat);

              // sorting functions by datetime & timeofday
              int compareTOD(TimeOfDay a, TimeOfDay b) {
                double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;
                return toDouble(a).compareTo(toDouble(b));
              }

              finalList.sort((a, b) => (a.selectedDate.compareTo(b.selectedDate) != 0)
                ? a.selectedDate.compareTo(b.selectedDate)
                : compareTOD(a.selectedTime, b.selectedTime)
              );

              return Container(
                  child: Column(
                    children: <Widget>[
                      CustomisedAppBar(),

                      Row(
                        children: [
                          Expanded(flex: 2, child: ScreenHeader(name: "Respond")),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 0.1 * size.width),
                            width: 0.45 * size.width,
                            child: DropdownButtonFormField(
                              isDense: true,
                              isExpanded: true,
                              value: currentCat ?? "FILTER",
                              items: category.map((item){
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: Colors.teal[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 0.02 * size.height,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) => setState(() => currentCat = val),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: finalList.length,
                            itemBuilder: (context, index) {
                              return finalList[index];
                            }
                          ),
                        ),
                      ),
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
