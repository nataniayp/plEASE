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

  RequestCard convertMapToRequestCard(Map<String, dynamic> map) {
    return RequestCard(
      uid: map['uid'],
      userName: map['name'],
      category: map['cat'],
      itemName: map['item'],
      quantity: map['quantity'],
      selectedDate: DateTime.parse(map['date']),
      selectedTime: TimeOfDay(
          hour: int.parse(map['time'].split(":")[0]),
          minute: int.parse(map['time'].split(":")[1].substring(0,2))
      ),
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
                return Column(
                  children: <Widget>[
                    CustomisedAppBar(withBackArrow: true,),
                    ScreenHeader(name: 'My Responses'),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: convertList(userCred.resList).length,
                            itemBuilder: (context, index) {
                              return convertList(userCred.resList)[index];
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
