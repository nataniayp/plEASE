import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_card.dart';
import 'package:please/components/screen_header.dart';
import 'package:intl/intl.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';

class RespondDetails extends StatefulWidget {
  const RespondDetails({Key key}) : super(key: key);

  @override
  _RespondDetailsState createState() => _RespondDetailsState();
}

class _RespondDetailsState extends State<RespondDetails> {
  String convertTimeOfDayToString(TimeOfDay t) {
    String hour = t.hourOfPeriod.toString();
    String min = t.minute < 10 ? '0' + t.minute.toString() : t.minute.toString();
    int period = t.period.index;

    if (period == 0) {
      return hour + ':' + min + ' AM';
    } else {
      return hour + ':' + min + ' PM';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RequestCard rc = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<UserData>(context);

    List<String> users = [rc.uid, user.uid];
    String chatRoomId = "${rc.uid}_${user.uid}";
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UserCredentials>(
          stream: DatabaseService(uid: user.uid).userCredentials,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomisedAppBar(withBackArrow: true,),
                  ScreenHeader(name: 'Respond Details'),
                  Text('Category: ${rc.category}'),
                  SizedBox(height: 0.02 * size.height),
                  Text('Item: ${rc.itemName}',),
                  SizedBox(height: 0.02 * size.height),
                  Text('Quantity: ${rc.quantity}',),
                  SizedBox(height: 0.02 * size.height),
                  Text('by ${DateFormat('EEE, d/M/y,').format(rc.selectedDate)} ${convertTimeOfDayToString(rc.selectedTime)}'),
                  // Text('by ${DateFormat('EEE, d/M/y,').format(rc.selectedDate)} ${rc.selectedTime.format(context)}'),
                  SizedBox(height: 0.02 * size.height),
                  Text('Requested by: ${rc.userName}'),
                  SizedBox(height: 0.02 * size.height),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
                    child: FlatButton(
                      // TODO change routing to chatroom
                      onPressed: user.uid == rc.uid? null: () async {
                        rc.reqAccepted(snapshot.data.name, snapshot.data.uid);
                        await DatabaseService(uid: user.uid).deleteAcceptedReq(
                            rc.uid,
                            rc.userName,
                            rc.category,
                            rc.itemName,
                            rc.quantity,
                            DateFormat('yyyy-MM-dd').format(rc.selectedDate),
                            convertTimeOfDayToString(rc.selectedTime),
                        );
                        await DatabaseService(uid: user.uid).addAcceptedReq(
                          rc.uid,
                          rc.userName,
                          rc.category,
                          rc.itemName,
                          rc.quantity,
                          DateFormat('yyyy-MM-dd').format(rc.selectedDate),
                          convertTimeOfDayToString(rc.selectedTime),
                          rc.acceptedBy,
                        );
                        await DatabaseService(uid: user.uid).addResponse(
                            rc.uid,
                            rc.userName,
                            rc.category,
                            rc.itemName,
                            rc.quantity,
                            DateFormat('yyyy-MM-dd').format(rc.selectedDate),
                            convertTimeOfDayToString(rc.selectedTime),
                            rc.acceptedBy,
                        );
                        await DatabaseService(chatRoomId: chatRoomId).createChatRoom(chatRoomMap);
                        await Navigator.pushReplacementNamed(context, '/my_responses');
                      },
                      color: Colors.white,
                      height: 50.0,
                      minWidth: 200.0,
                      child: Text(
                        'ACCEPT',
                        style: TextStyle(
                          color: user.uid == rc.uid ? Colors.grey[500]: Colors.teal[900],
                          letterSpacing: 1.7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  (user.uid == rc.uid)
                    ? FlatButton(
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).deleteAcceptedReq(
                          rc.uid,
                          rc.userName,
                          rc.category,
                          rc.itemName,
                          rc.quantity,
                          DateFormat('yyyy-MM-dd').format(rc.selectedDate),
                          convertTimeOfDayToString(rc.selectedTime),
                        );
                        await Navigator.pop(context);
                        // await Navigator.pushReplacementNamed(context, '/my_requests');
                      },
                      height: 50.0,
                      minWidth: 200.0,
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                          color: Colors.teal[900],
                          letterSpacing: 1.7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) : Container()
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

