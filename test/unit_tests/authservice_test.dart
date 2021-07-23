import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:please/services/auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}

void main () {

  final MockFirebaseAuth _auth = MockFirebaseAuth();

  AuthService auth = AuthService(auth: _auth);

  group('Register test', (){
    test('Register with email and password', () async {
      when (_auth.createUserWithEmailAndPassword(email: 'email', password: 'password'))
          .thenAnswer((realInvocation) => null);

      expect(await auth.registerWithEmailAndPassword('test', 'email', 'password'), 'Registration successful');
    });
    
    test('Register exception', () async {
      when (_auth.createUserWithEmailAndPassword(email: 'email', password: '123456'))
          .thenAnswer((realInvocation) => throw FirebaseAuthException(message: 'Register exception'));

      expect(await auth.registerWithEmailAndPassword('test', 'email', '123456'), 'Register exception');
    });
  });

  group('Sign in test', (){
    test('Sign in with email and password', () async {
      when (_auth.signInWithEmailAndPassword(email: 'email', password: 'password'))
      .thenAnswer((realInvocation) => null);

      expect(await auth.signInWithEmailAndPassword('email','password'), 'Sign in successful');
    });

    test('Sign in exception', () async {
      when (_auth.signInWithEmailAndPassword(email: 'email', password: '123456'))
          .thenAnswer((realInvocation) => throw FirebaseAuthException(message: 'Sign in exception'));

      expect(await auth.signInWithEmailAndPassword('email', '123456'), 'Sign in exception');
    });
  });
}