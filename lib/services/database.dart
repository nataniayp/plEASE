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
    });
  }

  // userInfo list from snapshot
  List<UserCredentials> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
     return UserCredentials(
       uid: doc.get('uid') ?? '',
       name: doc.get('name') ?? '',
     );
    }).toList();
  }

  // get userData stream
  Stream<List<UserCredentials>> get userData {
    return userCollection.snapshots()
      .map(_userInfoListFromSnapshot);
  }
}