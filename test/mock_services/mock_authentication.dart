import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:please/services/auth.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class MockAuthService extends AuthService {
  @override
  final _auth = MockFirebaseAuth();

  @override
  final db = FakeFirebaseFirestore();

  @override
  final userRef = FakeFirebaseFirestore().collection('userInfo');
}