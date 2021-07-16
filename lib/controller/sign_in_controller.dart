import 'package:please/services/auth.dart';

class SignInController {
  final AuthService _auth = AuthService();

  Future signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email,
      password
    );
  }

}