import 'package:firebase_auth/firebase_auth.dart';
import 'package:please/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  // sign in with email & password

  // register with email & password
  Future registerWithEmailAndPassword(String userName, String email, String password) async {
    try {
      AuthResult result =
        await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password);
      FirebaseUser user = result.user;
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