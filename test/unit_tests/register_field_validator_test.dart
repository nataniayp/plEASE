import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:please/screens/authenticate/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // name validation
  group('Name validation upon login:', (){
    test('name input is valid', (){
      var result = FieldValidator.nameValidator('testName');
      expect(result, null);
    });

    test('name input is empty', (){
      var result = FieldValidator.nameValidator('');
      expect(result, 'Enter a name');
    });
  });

  // email validation
  group('Email validation upon login:', () {
    test('email input is valid', () {
      var result = FieldValidator.emailValidator('test');
      expect(result, null);
    });

    test('email input is empty', () {
      var result = FieldValidator.emailValidator('');
      expect(result, 'Enter an email');
    });

  });

  // password validation
  group('Password validation upon login:', () {
    test('password input is valid', () {
      var result = FieldValidator.passwordValidator('password');
      expect(result, null);
    });

    test('password input has less than 6 characters', () {
      var result = FieldValidator.passwordValidator('test');
      expect(result, 'Enter a password with 6+ characters');
    });

    test('password input is empty', () {
      var result = FieldValidator.passwordValidator('');
      expect(result, 'Enter a password with 6+ characters');
    });
  });
}