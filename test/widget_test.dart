import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:please/main.dart';

void main() {
  // setUpAll(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // });

  // sign in page displayed
  testWidgets('sign in displayed initially', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Sign In'), findsOneWidget);
  });

  // // register
  // testWidgets('page changed to register', (WidgetTester tester) async {
  //   await tester.pumpWidget(MyApp());
  //
  //   await tester.tap(find.byType(TextButton));
  //   await tester.pump();
  //   expect(find.text('Register'), findsOneWidget);
  //   await tester.pumpAndSettle(const Duration(seconds: 5));
  // });

}