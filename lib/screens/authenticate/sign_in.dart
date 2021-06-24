import 'package:flutter/material.dart';
import 'package:please/screens/authenticate/reset.dart';
import 'package:please/services/auth.dart';
import 'package:please/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
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
                    "Sign In",
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
                      "REGISTER",
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
                      SizedBox(
                        height: 0.1 * size.width,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white,),
                        decoration: InputDecoration(
                          suffixText: '@u.nus.edu',
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
                          String suffix = '@u.nus.edu';
                          setState(() => email = val + suffix);
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
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    email,
                                    password
                                );
                            if (result == null) {
                              setState(() {
                                error = 'Incorrect email/password';
                                loading = false;
                              });
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Reset()),
                          );
                        },
                        child: Text(
                            'Forgot password?',
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
      ),
    );
  }
}
