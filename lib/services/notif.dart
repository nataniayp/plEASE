import 'dart:convert';

import 'package:http/http.dart';

class Notif {

  Future<Response> sendNotification(List<String> tokenIdList) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": '729732d6-6359-40bb-8847-ca6e0c987d25',
        "include_player_ids": tokenIdList,
        "android_accent_color":"FF9976D2",
        "small_icon":"https://i.ibb.co/S5FHpXF/pl-EASE-1028.png",
        "large_icon":"https://i.ibb.co/S5FHpXF/pl-EASE-1028.png",
        "headings": {"en": 'plEASE'},
        "contents": {"en": 'Your request has been accepted!'},
      }),
    );
  }
}