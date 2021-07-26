import 'package:please/models/request_item.dart';
import 'package:please/services/database.dart';
import 'package:please/services/notif.dart';

class RespondDetailsController {
  Notif notif = Notif();

  // deleting a request
  Future<void> deleteRequest(RequestItem req, String uid) async {
    await DatabaseService(uid: uid).deleteReq(req);
  }

  // accepting a request
  Future<void> acceptRequest(RequestItem req, String uid, String acceptedBy, String acceptedByUid, List<String> tokenIdList, String chatRoomId, Map<String, dynamic> chatRoomMap) async {
    req.reqAccepted(acceptedBy, acceptedByUid);
    notif.sendNotification(tokenIdList);

    await DatabaseService(uid: uid).deleteReq(req);
    await DatabaseService(uid: uid).addAcceptedReq(req);
    await DatabaseService(uid: uid).addResponse(req);
    await DatabaseService(chatRoomId: chatRoomId).createChatRoom(chatRoomMap);
  }
}