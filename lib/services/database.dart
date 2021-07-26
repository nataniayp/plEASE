import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:please/models/request_item.dart';
import 'package:please/models/user_credentials.dart';
import 'package:please/models/message_data.dart';

class DatabaseService {
  final String uid;
  final String chatRoomId;
  DatabaseService({ this.uid, this.chatRoomId });

  // collection reference for userInfo
  final CollectionReference userCollection
    = FirebaseFirestore.instance.collection('userInfo');

  // collection reference for chatRoom
  final CollectionReference chatRoomCollection
  = FirebaseFirestore.instance.collection('chatRoom');

  // initial storing of data after registering
  Future updateUserData(String name) async {
    // get tokenId
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String tokenId = status.subscriptionStatus.userId;

    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'reqList': [],
      'resList': [],
      'tokenIds': [tokenId],
    });
  }

  // update tokenId after signing in
  Future addTokenId() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String tokenId = status.subscriptionStatus.userId;

    return await userCollection.doc(uid).update({
      'tokenIds': FieldValue.arrayUnion([tokenId]),
    });
  }

  // delete tokenId after logging out
  Future deleteTokenId() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String tokenId = status.subscriptionStatus.userId;

    return await userCollection.doc(uid).update({
      'tokenIds': FieldValue.arrayRemove([tokenId]),
    });
  }

  Future addRequestItem(RequestItem req) async {
    return await userCollection.doc(uid).update({
      'reqList': FieldValue.arrayUnion([{
        'uid': uid,
        'name': req.userName,
        'cat': req.category,
        'item': req.itemName,
        'quantity': req.quantity,
        'date': DateFormat('yyyy-MM-dd').format(req.date),
        'time': req.getTimeInString(),
        'accepted': false,
        'acceptedBy': '',
        'acceptedByUid': '',
      }]),
    });
  }



  // the three methods below are used when a user accepts another user's request
  Future deleteReq(RequestItem req) async {
    return await userCollection.doc(req.uid).update({
      'reqList': FieldValue.arrayRemove([{
        'uid': req.uid,
        'name': req.userName,
        'cat': req.category,
        'item': req.itemName,
        'quantity': req.quantity,
        'date': req.getDateInString(),
        'time': req.getTimeInString(),
        'accepted': false,
        'acceptedBy': '',
        'acceptedByUid': '',
      }]),
    });
  }

  Future addAcceptedReq(RequestItem req) async {
    return await userCollection.doc(req.uid).update({
      'reqList': FieldValue.arrayUnion([{
        'uid': req.uid,
        'name': req.userName,
        'cat': req.category,
        'item': req.itemName,
        'quantity': req.quantity,
        'date': req.getDateInString(),
        'time': req.getTimeInString(),
        'accepted': true,
        'acceptedBy': req.acceptedBy,
        'acceptedByUid': uid,
      }]),
    });
  }

  Future addResponse(RequestItem req) async {
    return await userCollection.doc(uid).update({
      'resList': FieldValue.arrayUnion([{
        'uid': req.uid,
        'name': req.userName,
        'cat': req.category,
        'item': req.itemName,
        'quantity': req.quantity,
        'date': req.getDateInString(),
        'time': req.getTimeInString(),
        'accepted': true,
        'acceptedBy': req.acceptedBy,
        'acceptedByUid': uid,
      }]),
    });
  }

  // userInfo list from snapshot
  List<UserCredentials> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return UserCredentials(
        doc.get('uid') ?? '',
        doc.get('name') ?? '',
        doc.get('reqList') ?? [],
        doc.get('resList') ?? [],
      );
    }).toList();
  }

  // userCredentials from snapshot
  UserCredentials _userCredentialsFromSnapshot(DocumentSnapshot snapshot) {
    return UserCredentials(
      uid,
      snapshot.get('name'),
      snapshot.get('reqList'),
      snapshot.get('resList'),
    );
  }

  // get userData stream
  Stream<List<UserCredentials>> get userData {
    return userCollection.snapshots()
      .map(_userInfoListFromSnapshot);
  }

  // get user doc stream
  Stream<UserCredentials> get userCredentials {
    return userCollection.doc(uid).snapshots()
      .map(_userCredentialsFromSnapshot);
  }

  // tokenIds from snapshot
  List<String> _tokenIdsFromSnapshot(DocumentSnapshot snapshot) {
    List<dynamic> tokenDynamic = snapshot.get('tokenIds');
    List<String> tokenString = tokenDynamic.map((i) => i as String).toList();
    return tokenString;
  }

  // get tokenIds stream
  Stream<List<String>> getTokenIds(String tokenUid) {
    return userCollection.doc(tokenUid).snapshots().map(_tokenIdsFromSnapshot);
  }

  // create new chat room between requester and responder
  Future createChatRoom(chatRoomMap) async {
    return await chatRoomCollection.doc(chatRoomId)
      .set(chatRoomMap)
      .catchError((e) {
        print(e.toString());
      });
  }

  // add new message to current list of messages
  Future addMessages(messageMap) async {
    return await chatRoomCollection.doc(chatRoomId)
      .collection("messages") // creates "messages" collection if it does not already exist
      .add(messageMap)
      .catchError((e){
        print(e.toString());
    });
  }

  // messageData from snapshot
  List<MessageData> _messageDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MessageData(
        message: doc.get("message") ?? null,
        sendBy: doc.get("sendBy") ?? null,
        sendTime: DateTime.parse(doc.get("sendTime").toDate().toString()) ?? null,
      );
    }).toList();
  }

  // get message stream
  Stream<List<MessageData>> get messageData {
    return chatRoomCollection
      .doc(chatRoomId)
      .collection("messages") // nested collection
      .snapshots() // get individual documents
      .map(_messageDataFromSnapshot); // invoke function on individual documents
  }
}