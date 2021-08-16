import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xff4a675a), const Color(0xff3a4a51)]
        ),
      ),
      child: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 0.25 * size.width,
        )
      ),
    );
  }
}
