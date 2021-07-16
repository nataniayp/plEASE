import 'package:please/services/auth.dart';

class RegisterController {
  final AuthService _auth = AuthService();

  Future register(String userName, String email, String password) async {
    return await _auth.registerWithEmailAndPassword(
        userName, email, password);
  }
}