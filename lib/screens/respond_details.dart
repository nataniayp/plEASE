import 'package:flutter/material.dart';
import 'package:please/components/customised_app_bar.dart';
import 'package:please/components/screen_header.dart';

class RespondDetails extends StatefulWidget {
  const RespondDetails({Key key}) : super(key: key);

  @override
  _RespondDetailsState createState() => _RespondDetailsState();
}

class _RespondDetailsState extends State<RespondDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomisedAppBar(name: 'Natania', withBackArrow: true,),
            ScreenHeader(name: 'Respond Details'),
            Text('Category: Food',),
            Text('Item: aglio olio',),
            Text('Quantity: 1',),
            Text('By 26-5-2021, 9:00pm',),
            SizedBox(height: size.height * 0.02,),
            Padding(
              padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/my_responses');
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
        ),
      ),
    );
  }
}

