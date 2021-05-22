import 'package:flutter/material.dart';
import 'package:please/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0.1 * size.width),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sign In",
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("REGISTER"),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(0.1 * size.width),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 0.1 * size.width,
                    ),
                    SizedBox(
                      height: 0.1 * size.width,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 0.05 * size.width,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 0.1 * size.width,
                    ),
                    TextButton(
                      onPressed: () async {
                        print(email);
                        print(password);
                      },
                      child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.grey[500],
                            letterSpacing: 1.7,
                          )
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
