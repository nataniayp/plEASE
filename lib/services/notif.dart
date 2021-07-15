import 'dart:convert';

import 'package:http/http.dart';

class Notif {

  Future<Response> sendNotification(List<String> tokenIdList, String contents, String heading) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": '729732d6-6359-40bb-8847-ca6e0c987d25',//kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color represent the color of the heading text in the notification
        "android_accent_color":"FF9976D2",

        "small_icon":"https://i.ibb.co/S5FHpXF/pl-EASE-1028.png",

        "large_icon":"https://i.ibb.co/S5FHpXF/pl-EASE-1028.png",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }
}