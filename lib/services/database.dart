import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future updateUserData(String name) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'reqList': [],
      'resList': [],
    });
  }

  // add a RequestItem
  Future addRequestItem(String name, String cat, String item, int quantity, String date, String time) async {
    return await userCollection.doc(uid).update({
      'reqList': FieldValue.arrayUnion([{
        'uid': uid,
        'name': name,
        'cat': cat,
        'item': item,
        'quantity': quantity,
        'date': date,
        'time': time,
        'accepted': false,
        'acceptedBy': '',
        'acceptedByUid': '',
      }]),
    });
  }

  // the three methods below are used when a user accepts another user's request
  Future deleteAcceptedReq(
    String uidReq,
    String name,
    String cat,
    String item,
    int quantity,
    String date,
    String time,
    ) async {
    return await userCollection.doc(uidReq).update({
      'reqList': FieldValue.arrayRemove([{
        'uid': uidReq,
        'name': name,
        'cat': cat,
        'item': item,
        'quantity': quantity,
        'date': date,
        'time': time,
        'accepted': false,
        'acceptedBy': '',
        'acceptedByUid': '',
      }]),
    });
  }

  Future addAcceptedReq(
      String uidReq,
      String name,
      String cat,
      String item,
      int quantity,
      String date,
      String time,
      String acceptedBy
    ) async {
    return await userCollection.doc(uidReq).update({
      'reqList': FieldValue.arrayUnion([{
        'uid': uidReq,
        'name': name,
        'cat': cat,
        'item': item,
        'quantity': quantity,
        'date': date,
        'time': time,
        'accepted': true,
        'acceptedBy': acceptedBy,
        'acceptedByUid': uid,
      }]),
    });
  }

  Future addResponse(
      String uidReq,
      String name,
      String cat,
      String item,
      int quantity,
      String date,
      String time,
      String acceptedBy
    ) async {
    return await userCollection.doc(uid).update({
      'resList': FieldValue.arrayUnion([{
        'uid': uidReq,
        'name': name,
        'cat': cat,
        'item': item,
        'quantity': quantity,
        'date': date,
        'time': time,
        'accepted': true,
        'acceptedBy': acceptedBy,
        'acceptedByUid': uid,
      }]),
    });
  }

  // userInfo list from snapshot
  List<UserCredentials> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      // print(doc.data());
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

  // create new chat room between requester and responder
  createChatRoom(chatRoomMap) {
    chatRoomCollection.doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
          print(e.toString());
        });
  }

  // add new message to current list of messages
  addMessages(messageMap){
    chatRoomCollection.doc(chatRoomId)
        .collection("messages") // creates "messages" collection if it does not already exist
        .add(messageMap)
        .catchError((e){
          print(e.toString());
    });
  }

  // // get requester and responder uid
  // Future<List<String>> getUid () async {
  //   DocumentSnapshot selected = await chatRoomCollection.doc(chatRoomId).get();
  //   return selected['users'];
  // }

  // messageData from snapshot
  List<MessageData> _messageDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return MessageData(
        message: doc.get("message") ?? null,
        sendBy: doc.get("sendBy") ?? null,
        sendTime: DateTime.parse(doc.get("sendTime").toDate().toString()).add(
            Duration(hours: 8) //  accounts for time difference (temporary fix for SG only)
        ) ?? null,
      );
    }).toList();
  }

  // get message stream
  Stream<List<MessageData>> get messageData{
    return chatRoomCollection
        .doc(chatRoomId)
        .collection("messages") // nested collection
        .snapshots() // get individual documents
        .map(_messageDataFromSnapshot); // invoke function on individual documents
  }
}