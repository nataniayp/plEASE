import 'package:flutter/material.dart';
import 'package:please/controller/reset_controller.dart';
import 'package:please/shared/loading.dart';

class Reset extends StatefulWidget {
  const Reset({Key key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final _formKey = GlobalKey<FormState>();
  ResetController con = ResetController();
  bool loading = false;
  String _email = '';
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
              Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.5,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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
                            setState(() => _email = val + suffix);
                          },
                        ),
                        SizedBox(
                          height: 0.05 * size.width,
                        ),
                        TextButton(
                          onPressed: () async {
                            setState(() => loading = true);
                            await con.resetPassword(_email);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              'RESET',
                              style: TextStyle(
                                color: Colors.grey[500],
                                letterSpacing: 1.7,
                              )
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              'back',
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
