import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/components/request_card.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';

class MyResponses extends StatefulWidget {
  const MyResponses({Key key}) : super(key: key);

  @override
  _MyResponsesState createState() => _MyResponsesState();
}

class _MyResponsesState extends State<MyResponses> {

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
      // selectedTime: TimeOfDay(hour: int.parse(map['time'].split(":")[0]), minute: int.parse(map['time'].split(":")[1].substring(0,2))),
      accepted: map['accepted'],
      acceptedBy: map['acceptedBy'],
      acceptedByUid: map['acceptedByUid'],
    );
  }

  List<RequestCard> convertList(List<dynamic> myList) {
    return myList.map((item) => convertMapToRequestCard(item)).toList();
  }

  // sorting functions by datetime & timeofday
  int compareTOD(TimeOfDay a, TimeOfDay b) {
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;
    return toDouble(a).compareTo(toDouble(b));
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
                List<RequestCard> finalList = convertList(userCred.resList);

                // sorting functions by datetime & timeofday
                int compareTOD(TimeOfDay a, TimeOfDay b) {
                  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;
                  return toDouble(a).compareTo(toDouble(b));
                }

                finalList.sort((a, b) => (a.selectedDate.compareTo(b.selectedDate) != 0)
                    ? a.selectedDate.compareTo(b.selectedDate)
                    : compareTOD(a.selectedTime, b.selectedTime)
                );


                return Column(
                  children: <Widget>[
                    CustomisedAppBar(withBackArrow: true,),
                    ScreenHeader(name: 'My Responses'),
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
