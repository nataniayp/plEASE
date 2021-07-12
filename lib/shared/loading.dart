import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.teal[900],
      child: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 0.25 * size.width,
        )
      ),
    );
  }
}
