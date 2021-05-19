import 'package:flutter/material.dart';

class RequestInput extends StatefulWidget {
  const RequestInput({Key key}) : super(key: key);

  @override
  _RequestInputState createState() => _RequestInputState();
}

class _RequestInputState extends State<RequestInput> {

  String dropdownValue = 'Food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Input'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
          //   child: DropdownButton(
          //     value: dropdownValue,
          //     icon: const Icon(Icons.arrow_downward),
          //     iconSize: 24,
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         dropdownValue = newValue;
          //       });
          //     },
          //     items: <String>['Food', 'Stationery', 'Cleaning supplies', 'Others']
          //       .map<DropdownMenuItem<String>>((String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: Text(value),
          //         )
          //     }).toList(),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
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
                child: Text(
                  'submit',
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
