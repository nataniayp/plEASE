import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:please/models/user_credentials.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection
    = FirebaseFirestore.instance.collection('userInfo');

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
}