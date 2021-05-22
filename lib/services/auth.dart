import 'package:firebase_auth/firebase_auth.dart';
import 'package:please/models/user_data.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserData> get user {
    // return _auth.onAuthStateChanged
    //   .map(_userFromFirebaseUser);
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String userName, String email, String password) async {
    try {
      UserCredential result =
        await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      return null;
    }
  }

}