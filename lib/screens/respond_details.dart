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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RequestCard rc = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UserCredentials>(
          stream: DatabaseService(uid: user.uid).userCredentials,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomisedAppBar(withBackArrow: true,),
                  ScreenHeader(name: 'Respond Details'),
                  Text('Category: ${rc.category}'),
                  Text('Item: ${rc.itemName}',),
                  Text('Quantity: ${rc.quantity}',),
                  Text('by ${DateFormat('EEE, d/M/y,').format(rc.selectedDate)} ${rc.selectedTime.format(context)}'),
                  Text('Requested by: ${rc.userName}'),
                  SizedBox(height: size.height * 0.02,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
                    child: FlatButton(
                      onPressed: () async {
                        rc.reqAccepted(snapshot.data.name, snapshot.data.uid);

                        await Navigator.pushReplacementNamed(context, '/my_responses');
                      },
                      color: Colors.white,
                      height: 50.0,
                      minWidth: 200.0,
                      child: Text(
                        'ACCEPT',
                        style: TextStyle(
                          color: Colors.teal[900],
                          letterSpacing: 1.7,
                          fontWeight: FontWeight.bold,
                        ),
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

