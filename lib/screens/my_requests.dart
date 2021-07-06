import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/components/request_card.dart';
import 'package:please/models/request_item.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key key}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
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
      rq: RequestItem(
        map['uid'],
        map['name'],
        map['cat'],
        map['item'],
        map['quantity'],
        DateTime.parse(map['date']),
        convertStringToTimeOfDay(map['time']),
        map['accepted'],
        map['acceptedBy'],
        map['acceptedByUid'],
      ),
      routeToChatRoom: true,
    );
  }

  List<RequestCard> convertList(List<dynamic> myList) {
    return myList.map((item) => convertMapToRequestCard(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UserCredentials>(
          stream: DatabaseService(uid: user.uid).userCredentials,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserCredentials userCred = snapshot.data;

              List<RequestCard> finalList = convertList(userCred.reqList);

              // finalList.sort((a, b) => (a.rq.date.compareTo(b.rq.date) != 0)
              //     ? a.rq.date.compareTo(b.rq.date)
              //     : a.rq.compareReqTOD(b.rq)
              // );

              finalList.sort((a, b) => a.rq.compareReq(b.rq));

              return Column(
                children: <Widget>[
                  CustomisedAppBar(withBackArrow: true,),
                  ScreenHeader(name: 'My Requests'),
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
              );
            } else {
              return Loading();
            }
          }
        ),
      ),
    );
  }
}
