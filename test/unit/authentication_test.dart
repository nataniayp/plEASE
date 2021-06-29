import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:please/main.dart';
import 'package:please/models/user_data.dart';
import 'package:please/screens/authenticate/authenticate.dart';
import 'package:please/screens/authenticate/sign_in.dart';
import 'package:please/screens/wrapper.dart';
import '../mock_services/mock_authentication.dart';
import 'dart:io' as io;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // login
  group('Email validation upon login:', () {
    test('email is in correct format', () {
      var result = FieldValidator.emailValidator('test');
      expect(result, null);
    });

    test('email should not be empty', () {
      var result = FieldValidator.emailValidator('');
      expect(result, 'Enter an email');
    });

    test('email is registered', () {
      var result = FieldValidator.emailValidator('yovela');
      expect(result, null);
    });

  });

  group('Password validation upon login:', () {
    test('password should have at least 6 chars', () {
      var result = FieldValidator.passwordValidator('test');
      expect(result, 'Enter a password with 6+ characters');
    });

    test('password should not be empty', () {
      var result = FieldValidator.passwordValidator('');
      expect(result, 'Enter a password with 6+ characters');
    });
  });
}