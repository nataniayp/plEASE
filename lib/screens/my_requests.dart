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

List<RequestCard> convertList(List<dynamic> myList) {
  return myList.map((item) =>
      RequestCard(
        rq: RequestItem.fromMap(item),
        routeToChatRoom: true,
      )
  ).toList();
}

class MyRequests extends StatefulWidget {
  const MyRequests({Key key}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

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
