import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:please/screens/request_input.dart';
import 'package:please/screens/my_requests.dart';
import 'package:please/screens/my_responses.dart';
import 'package:please/screens/respond_details.dart';
import 'package:please/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:please/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:please/models/user_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Please',
        home: Wrapper(),
        routes: {
          '/': (context) => Home(),
        '/my_requests': (context) => MyRequests(),
        '/request_input': (context) => RequestInput(),
        '/my_responses': (context) => MyResponses(),
        '/respond_details': (context) => RespondDetails(),
        },
      ),
    );
  }
}