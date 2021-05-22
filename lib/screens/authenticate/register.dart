import 'package:flutter/material.dart';
import 'package:please/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String userName = '';
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
                  "Register",
                ),
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Text("SIGN IN"),
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
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? 'Enter a name'
                            : null,
                        onChanged: (val) {
                          setState(() => userName = val);
                        },
                      ),
                      SizedBox(
                        height: 0.05 * size.width,
                      ),
                      TextFormField(
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
                              await _auth.registerWithEmailAndPassword(
                                  userName, email, password);
                            if (result == null) {
                              setState(() => error =
                              'Enter a valid email');
                            }
                          }
                        },
                        child: Text(
                            'REGISTER',
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
