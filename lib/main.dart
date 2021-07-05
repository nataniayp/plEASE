import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:please/screens/request_input.dart';
import 'package:please/screens/my_requests.dart';
import 'package:please/screens/my_responses.dart';
import 'package:please/screens/respond_details.dart';
import 'package:please/screens/wrapper.dart';
import 'package:please/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:please/models/user_data.dart';
import 'screens/chatroom.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var status = await OneSignal.shared.getPermissionSubscriptionState();
  // String tokenId = status.subscriptionStatus.userId;
  // print(tokenId);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configOneSignal();

  }

  void configOneSignal()
  {
    OneSignal.shared.init('729732d6-6359-40bb-8847-ca6e0c987d25');
  }




  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Please',
        home: Wrapper(),
        routes: {
          // '/': (context) => Home(),
          '/my_requests': (context) => MyRequests(),
          '/request_input': (context) => RequestInput(),
          '/my_responses': (context) => MyResponses(),
          '/respond_details': (context) => RespondDetails(),
          '/chatroom': (context) => ChatRoom(),
        },
      ),
    );
  }
}