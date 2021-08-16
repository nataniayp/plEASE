import 'package:flutter/material.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';

class CustomisedAppBar extends StatefulWidget {
  const CustomisedAppBar({
    Key key,
    this.withBackArrow,
  }) : super(key: key);

  final bool withBackArrow;

  @override
  _CustomisedAppBarState createState() => _CustomisedAppBarState();
}

class _CustomisedAppBarState extends State<CustomisedAppBar> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final user = Provider.of<UserData>(context);

    return StreamBuilder<UserCredentials>(
      stream: DatabaseService(uid: user.uid).userCredentials,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: size.height * 0.23,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        // colors: [Colors.teal[900], Colors.grey[600]]
                      colors: [const Color(0xff4a675a), const Color(0xff3a4a51)],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
                Align(
                  // padding: EdgeInsets.only(
                  alignment: Alignment.center,
                  // ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: (widget.withBackArrow != null
                            && widget.withBackArrow) ? FlatButton(
                          child: Icon(Icons.arrow_back, color: Colors.white,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ) : Text(""),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Text(
                            "Hello,\n${snapshot.data.name}",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 3.0,
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.042,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // print(snapshot.error);
          return Loading();
        }
      }
    );
  }
}
