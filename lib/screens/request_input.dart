import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/request_item.dart';
import 'package:intl/intl.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';
import 'package:please/shared/loading.dart';
import 'package:provider/provider.dart';
import '../components/screen_header.dart';

class RequestInput extends StatefulWidget {
  const RequestInput({Key key}) : super(key: key);

  @override
  _RequestInputState createState() => _RequestInputState();
}

class _RequestInputState extends State<RequestInput> {
  
  RequestItem selected;
  List<String> category = ['Food', 'Stationery', 'Cleaning supplies', 'Others'];

  String convertCatName(String s) {
    if (s == 'Food') {
      return 'food';
    } else if (s == 'Stationery') {
      return 'stationery';
    } if (s == 'Cleaning supplies') {
      return 'cleaning';
    } else {
      return 'others';
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData>(context);

    Size size = MediaQuery.of(context).size;

    selected = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UserCredentials>(
          stream: DatabaseService(uid: user.uid).userCredentials,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomisedAppBar(withBackArrow: true,),
                    ScreenHeader(name: 'Request'),
                    Padding( // Category
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, size.height * 0.02, size.width * 0.1,
                          0),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text(selected.category),
                        onChanged: (val) {
                          setState(() {
                            selected.category = val;
                          });
                        },
                        items: category.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  cat,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding( // Item Name
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, size.height * 0.02, size.width * 0.1,
                          0),
                      child: TextField(
                        onChanged: (String text) {
                          setState(() {
                            selected.itemName = text;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal[900],
                            ),
                          ),
                          hintText: 'Enter item name',
                        ),
                      ),
                    ),
                    Padding( // Quantity
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, size.height * 0.02, size.width * 0.1,
                          0),
                      child: TextField(
                        onChanged: (String num) {
                          setState(() {
                            selected.quantity = int.parse(num);
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal[900],
                            ),
                          ),
                          hintText: 'Enter quantity',
                        ),
                      ),
                    ),
                    Padding( // Date
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, size.height * 0.02, size.width * 0.1,
                          0),
                      child: FlatButton.icon(
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2030)
                          );
                          if (picked != null) setState(() {
                            selected.date = picked;
                          });
                        },
                        icon: Icon(Icons.calendar_today),
                        label: Text(
                          selected.date == null ? 'Select date' : DateFormat(
                              'dd-MM-yyyy').format(selected.date),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        height: 50.0,
                        minWidth: 200.0,
                      ),
                    ),
                    Padding( // Time
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, size.height * 0.02, size.width * 0.1,
                          0),
                      child: FlatButton.icon(
                        onPressed: () async {
                          final TimeOfDay picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now()
                          );
                          if (picked != null) setState(() {
                            selected.time = picked;
                          });
                        },
                        icon: Icon(Icons.schedule),
                        label: Text(
                          selected.time == null ? 'Select time' : '${selected.time
                              .format(context)}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        height: 50.0,
                        minWidth: 200.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
                      child: FlatButton(
                        onPressed: () async {
                          await DatabaseService(uid: user.uid).addRequestItem(
                            snapshot.data.name,
                            convertCatName(selected.category),
                            selected.itemName,
                            selected.quantity,
                            DateFormat('yyyy-MM-dd').format(selected.date),
                            selected.time.format(context),
                          );

                          Navigator.pushReplacementNamed(
                              context, '/my_requests', arguments: selected);
                        },
                        color: Colors.white,
                        height: 50.0,
                        minWidth: 200.0,
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.teal[900],
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
