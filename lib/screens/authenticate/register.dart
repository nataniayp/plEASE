import 'package:flutter/foundation.dart';
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.teal[900], Colors.grey[600]]
          ),
        ),
        padding: EdgeInsets.all(0.1 * size.width),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.5,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.grey[500],
                      letterSpacing: 1.7,
                    ),
                  ),
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
                        style: TextStyle(color: Colors.white,),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.white,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,)
                          ),
                        ),
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
                        style: TextStyle(color: Colors.white,),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,)
                          ),
                        ),
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
                        style: TextStyle(color: Colors.white,),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white,),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,)
                          ),
                        ),
                        validator: (val) => val.length < 6
                            ? 'Enter a password with 6+ characters'
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
                              'Could not register, try again later');
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