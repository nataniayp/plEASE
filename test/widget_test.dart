import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:please/main.dart';
import 'package:please/screens/my_responses.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  // sign in page displayed
  testWidgets('sign in displayed initially', (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    await tester.pumpWidget(MyResponses());
    expect(find.text('My Responses'), findsOneWidget);
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