import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';

class RequestInput extends StatefulWidget {
  const RequestInput({Key key}) : super(key: key);

  @override
  _RequestInputState createState() => _RequestInputState();
}

class _RequestInputState extends State<RequestInput> {
  
  List<String> category = ['Food', 'Stationery', 'Cleaning supplies', 'Others'];
  String selectedCategory;

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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: DropdownButton(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter item name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter quantity',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter time',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: FlatButton(
              onPressed: () {},
              color: Colors.teal[900],
              height: 50.0,
              minWidth: 300.0,
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
