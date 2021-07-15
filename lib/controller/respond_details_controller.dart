import 'dart:convert';

import 'package:http/http.dart';
import 'package:please/models/request_item.dart';
import 'package:please/services/database.dart';

class RespondDetailsController {

  // deleting a request
  Future<void> deleteRequest(RequestItem req, String uid) async {
    await DatabaseService(uid: uid).deleteReq(req);
  }

  // accepting a request
  Future<void> acceptRequest(RequestItem req, String uid, String acceptedBy, String acceptedByUid, List<String> tokenIdList, String chatRoomId, Map<String, dynamic> chatRoomMap) async {
    req.reqAccepted(acceptedBy, acceptedByUid);
    sendNotification(tokenIdList);

    await DatabaseService(uid: uid).deleteReq(req);
    await DatabaseService(uid: uid).addAcceptedReq(req);
    await DatabaseService(uid: uid).addResponse(req);
    await DatabaseService(chatRoomId: chatRoomId).createChatRoom(chatRoomMap);
  }

  Future<Response> sendNotification(List<String> tokenIdList) async {
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

        "headings": {"en": 'plEASE'},

        "contents": {"en": 'Your request has been accepted!'},
      }),
    );
  }
}