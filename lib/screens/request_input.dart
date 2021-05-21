import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';

class RequestInput extends StatefulWidget {
  const RequestInput({Key key}) : super(key: key);

  @override
  _RequestInputState createState() => _RequestInputState();
}

class _RequestInputState extends State<RequestInput> {
  
  List<String> category = ['Food', 'Stationery', 'Cleaning supplies', 'Others'];
  int year = 2021;
  // var month = [for(var i = 1; i < 13; i+=1) i];
  // var day = [for(var i = 1; i < 32; i+=1) i];
  // var hr = [for(var i = 0; i < 24; i+=1) i];
  // var min = [for(var i = 0; i < 60; i+=1) i];
  String selectedCategory;
  DateTime selectedDate;
  TimeOfDay selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
              ),
            ],
          ),
          CustomisedAppBar(name: 'Request'),
          Padding( // Category
            padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(selectedCategory == null? 'Category': selectedCategory),
              onChanged: (val) {
                setState(() {
                  selectedCategory = val;
                });
              },
              items: category.map((cat) {
                return  DropdownMenuItem(
                  value: cat,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Text(
                        cat,
                        style:  TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding( // Item Name
            padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
            child: TextField(
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
            padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
            child: TextField(
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: FlatButton.icon(
              onPressed: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2030)
                );
                if (picked != null) setState(() {
                  selectedDate = picked;
                });
              },
              icon: Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null? 'Select time': '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              height: 50.0,
              minWidth: 200.0,
            ),
          ),
          Padding( // Time
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: FlatButton.icon(
              onPressed: () async {
                final TimeOfDay picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()
                );
                if (picked != null) setState(() {
                  selectedTime = picked;
                });
              },
              icon: Icon(Icons.schedule),
              label: Text(
                selectedTime == null? 'Select time': '${selectedTime.toString()}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              height: 50.0,
              minWidth: 200.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              height: 50.0,
              minWidth: 200.0,
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
