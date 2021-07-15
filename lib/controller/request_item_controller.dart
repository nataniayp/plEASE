import 'package:please/models/request_item.dart';
import 'package:please/services/database.dart';

class RequestItemController {

  // add a new request
  Future<void> addRequest(RequestItem req, String uid) async {
    return await DatabaseService(uid: uid).addRequestItem(req);
  }
}