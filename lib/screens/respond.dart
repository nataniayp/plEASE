import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/models/request_item.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';

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

List<RequestCard> convertList(List<dynamic> l) {
  return l.map((item) => RequestCard(
    rq: RequestItem.fromMap(item),
    routeToChatRoom: false,
  )).toList();
}

List<RequestCard> filterList(List<RequestCard> l, String s) {
  List<RequestCard> notAcceptedAndNotExpired = l.where((item) {
    return !item.rq.accepted && !item.rq.isExpired();
  }).toList();
  if (s == 'FILTER') {
    return notAcceptedAndNotExpired;
  } else {
    return notAcceptedAndNotExpired
        .where((item) => item.rq.category == convertCatName(s))
        .toList();
  }
}

List<RequestCard> flatMap(List<List<RequestCard>> l) {
  List<RequestCard> result = [];
  for (List<RequestCard> m in l) {
    result.addAll(m);
  }
  return result;
}

class Respond extends StatefulWidget {
  const Respond({Key key}) : super(key: key);

  @override
  _RespondState createState() => _RespondState();
}



class _RespondState extends State<Respond> {

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

              finalList.sort((a, b) => a.rq.compareReq(b.rq));

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
              return Loading();
            }
          }
        )
      ),
    );
  }
}
