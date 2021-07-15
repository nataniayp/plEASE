import 'package:firebase_auth/firebase_auth.dart';

class ResetController {
  final auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }
}