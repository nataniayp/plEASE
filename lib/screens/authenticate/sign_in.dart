import 'package:flutter/material.dart';
import 'package:please/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

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
                  onPressed: () {
                    widget.toggleView();
                  },
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
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (val) => val.isEmpty
                          ? 'Enter an email'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 0.05 * size.width,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (val) => val.isEmpty
                          ? 'Enter a password'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 0.1 * size.width,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email,
                                  password
                              );
                          if (result == null) {
                            setState(() => error =
                            'Incorrect email/password');
                          }
                        }
                      },
                      child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.grey[500],
                            letterSpacing: 1.7,
                          )
                      ),
                    ),
                    SizedBox(
                      height: 0.1 * size.width,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
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
