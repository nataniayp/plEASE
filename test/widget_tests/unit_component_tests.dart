import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:please/components/screen_header.dart';
import 'package:please/components/request_card.dart';
import 'package:please/models/request_item.dart';
import 'package:please/components/chatBubble.dart';
import 'package:please/components/customised_app_bar.dart';

void main() {

  // screen header test
  group('Screen header test', (){

    Widget testScreenHeader = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new ScreenHeader(name: 'Request'))
    );

    // screen header name
    testWidgets('screen header name', (WidgetTester tester) async {
      await tester.pumpWidget(testScreenHeader);
      expect(find.text('Request'), findsOneWidget);
    });
  });

  // request card test
  group('Request card test', (){

    Widget testRequestCard = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new RequestCard(
          rq: new RequestItem(
              'test',
              'Kenneth',
              'Food',
              'Aglio Olio',
              1,
              DateTime.parse('2021-07-14'),
              convertStringToTimeOfDay('2:00 PM'),
              false,
          )
        ))
    );

    // Request card name
    testWidgets('Request card name', (WidgetTester tester) async {
      await tester.pumpWidget(testRequestCard);
      expect(find.text('Kenneth wants'), findsOneWidget);
    });

    // Request card itemName and quantity
    testWidgets('Request card itemName and quantity', (WidgetTester tester) async {
      await tester.pumpWidget(testRequestCard);
      expect(find.text('Aglio Olio (1)'), findsOneWidget);
    });

    // TODO review formatting and unit test
    // // Request card date
    // testWidgets('Request card date', (WidgetTester tester) async {
    //   await tester.pumpWidget(testRequestCard);
    //   expect(find.text('by Wed, 14/7/2021, 14:00'), findsOneWidget);
    // });
  });

  // chat bubble test
  group('Chat bubble test', (){
    Widget testChatBubble = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new ChatBubble(
          message: 'This is a test message',
          isSentByUser: true,
          sendTime: DateTime.parse('2021-07-20 16:30:04'),
          showDate: true,
        ))
    );

    // chat bubble message
    testWidgets('Chat bubble message', (WidgetTester tester) async {
      await tester.pumpWidget(testChatBubble);
      expect(find.text('This is a test message'), findsOneWidget);
    });

    // chat bubble date
    testWidgets('Chat bubble date', (WidgetTester tester) async {
      await tester.pumpWidget(testChatBubble);
      expect(find.text('20/07/21'), findsOneWidget);
    });

    // chat bubble time
    testWidgets('Chat bubble time', (WidgetTester tester) async {
      await tester.pumpWidget(testChatBubble);
      expect(find.text('16:30'), findsOneWidget);
    });
  });

  group('Customised app bar test', (){
    Widget testCustomisedAppBar = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new CustomisedAppBar(withBackArrow: true,))
    );

    // customised app bar text
    testWidgets('Customised app bar text', (WidgetTester tester) async {
      await tester.pumpWidget(testCustomisedAppBar);
      expect(find.text('Hello, Kenneth'), findsOneWidget);
    });
  });
}