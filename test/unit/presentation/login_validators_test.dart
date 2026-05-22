import 'package:auror/common/strings/login_strings.dart';
import 'package:auror/layers/presentation/screens/login/login_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidEmailFormat', () {
    test('accepts valid email', () {
      expect(isValidEmailFormat('user@example.com'), isTrue);
    });

    test('rejects empty and invalid', () {
      expect(isValidEmailFormat(''), isFalse);
      expect(isValidEmailFormat('not-an-email'), isFalse);
    });
  });

  group('meetsSignUpPasswordRules', () {
    test('requires length, digit, uppercase, special', () {
      expect(meetsSignUpPasswordRules('short'), isFalse);
      expect(meetsSignUpPasswordRules('longenough1'), isFalse);
      expect(meetsSignUpPasswordRules('Longenough1'), isFalse);
      expect(meetsSignUpPasswordRules('Longenough1!'), isTrue);
    });
  });

  group('field errors', () {
    test('loginEmailError', () {
      expect(loginEmailError(''), isNull);
      expect(loginEmailError('   '), loginErrorEmailInvalid);
      expect(loginEmailError('bad'), loginErrorEmailInvalid);
      expect(loginEmailError('ok@mail.com'), isNull);
    });

    test('loginNameError', () {
      expect(loginNameError(''), isNull);
      expect(loginNameError('   '), loginErrorNameWhitespace);
      expect(loginNameError('Ada'), isNull);
    });

    test('loginPasswordError', () {
      expect(loginPasswordError('', isSignUp: false), isNull);
      expect(loginPasswordError('   ', isSignUp: false), loginErrorPasswordWhitespace);
      expect(loginPasswordError('x', isSignUp: false), isNull);
      expect(
        loginPasswordError('weak', isSignUp: true),
        loginErrorPasswordRequirements,
      );
      expect(loginPasswordError('Longenough1!', isSignUp: true), isNull);
    });

    test('loginConfirmPasswordError', () {
      expect(loginConfirmPasswordError('', 'a'), isNull);
      expect(loginConfirmPasswordError('b', 'a'), loginErrorPasswordMismatch);
      expect(loginConfirmPasswordError('a', 'a'), isNull);
    });
  });
}
