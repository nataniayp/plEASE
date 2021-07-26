import 'package:firebase_auth/firebase_auth.dart';
import 'package:please/models/user_data.dart';
import 'package:please/services/database.dart';


class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  // final FirebaseAuth auth;
  //
  // AuthService({this.auth});

  UserData _userFromFirebase(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  Stream<UserData> get user {
    return auth.authStateChanges().map((User user) => _userFromFirebase(user));
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      // return 'Sign in successful';
      User user = result.user;
      await DatabaseService(uid: user.uid).addTokenId();
      return _userFromFirebase(user);
    } on FirebaseAuthException catch(e) {
      // return e.message;
      print(e.toString());
      throw e;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String userName, String email, String password) async {
    try {
      UserCredential result =
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      User user = result.user;

      // create a new doc for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(userName);

      return _userFromFirebase(user);
      // return 'Registration successful';
    } on FirebaseAuthException catch(e) {
      // return e.message;

      print(e.toString());
      throw e;
    }
  }

  // sign out
  Future signOut() async {
    try {
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).deleteTokenId();
      return await auth.signOut();
    } catch(e) {
      return null;
    }
  }


}