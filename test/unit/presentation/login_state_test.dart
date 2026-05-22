import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('canSubmit for sign-in requires valid email and password', () {
    const state = LoginState(
      loginContext: LoginContext.signIn,
      email: 'user@example.com',
      password: 'secret',
    );
    expect(state.canSubmit, isTrue);
  });

  test('canSubmit for sign-up requires name and matching confirm password', () {
    const valid = LoginState(
      loginContext: LoginContext.signUp,
      name: 'Ada',
      email: 'ada@example.com',
      password: 'Longenough1!',
      confirmPassword: 'Longenough1!',
    );
    expect(valid.canSubmit, isTrue);

    const mismatch = LoginState(
      loginContext: LoginContext.signUp,
      name: 'Ada',
      email: 'ada@example.com',
      password: 'Longenough1!',
      confirmPassword: 'Other1!',
    );
    expect(mismatch.canSubmit, isFalse);
  });
}
