import 'package:auror/layers/data/datasource/auth_data_source.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/login/login_state.dart';
import 'package:auror/layers/presentation/screens/login/login_event.dart';
import 'package:auror/layers/presentation/screens/login/login_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks.mocks.dart';

void main() {
  late MockISignIn signIn;
  late MockISignUp signUp;

  setUp(() {
    signIn = MockISignIn();
    signUp = MockISignUp();
  });

  blocTest<LoginViewModel, LoginState>(
    'successful sign in invokes SignIn use case',
    build: () {
      when(
        signIn.call(email: anyNamed('email'), password: anyNamed('password')),
      ).thenAnswer((_) async {});
      return LoginViewModel(LoginContext.signIn, signIn, signUp);
    },
    act: (bloc) => bloc
      ..add(const LoginEmailChanged('user@example.com'))
      ..add(const LoginPasswordChanged('any-password'))
      ..add(const LoginSubmitTapped()),
    verify: (_) {
      verify(
        signIn.call(email: 'user@example.com', password: 'any-password'),
      ).called(1);
    },
  );

  blocTest<LoginViewModel, LoginState>(
    'email confirmation exception sets pendingEmailConfirmationNavigation',
    build: () {
      when(
        signIn.call(email: anyNamed('email'), password: anyNamed('password')),
      ).thenThrow(
        const AuthEmailConfirmationRequiredException(
          operation: 'signIn',
          cause: 'x',
        ),
      );
      return LoginViewModel(LoginContext.signIn, signIn, signUp);
    },
    act: (bloc) => bloc
      ..add(const LoginEmailChanged('user@example.com'))
      ..add(const LoginPasswordChanged('pw'))
      ..add(const LoginSubmitTapped()),
    verify: (bloc) {
      expect(bloc.state.pendingEmailConfirmationNavigation, isTrue);
      expect(bloc.state.isLoading, isFalse);
    },
  );

  blocTest<LoginViewModel, LoginState>(
    'successful sign up sets email confirmation navigation',
    build: () {
      when(
        signUp.call(
          email: anyNamed('email'),
          password: anyNamed('password'),
          displayName: anyNamed('displayName'),
        ),
      ).thenAnswer((_) async {});
      return LoginViewModel(LoginContext.signUp, signIn, signUp);
    },
    act: (bloc) => bloc
      ..add(const LoginNameChanged('Ada'))
      ..add(const LoginEmailChanged('ada@example.com'))
      ..add(const LoginPasswordChanged('Longenough1!'))
      ..add(const LoginConfirmPasswordChanged('Longenough1!'))
      ..add(const LoginSubmitTapped()),
    verify: (bloc) {
      expect(bloc.state.pendingEmailConfirmationNavigation, isTrue);
      verify(
        signUp.call(
          email: 'ada@example.com',
          password: 'Longenough1!',
          displayName: 'Ada',
        ),
      ).called(1);
    },
  );

  blocTest<LoginViewModel, LoginState>(
    'field and navigation events update state',
    build: () => LoginViewModel(LoginContext.signIn, signIn, signUp),
    act: (bloc) => bloc
      ..add(const LoginContextChanged(LoginContext.signUp))
      ..add(const LoginPasswordVisibilityToggled())
      ..add(const LoginConfirmPasswordVisibilityToggled())
      ..add(const LoginDashboardNavigationConsumed())
      ..add(const LoginSnackBarConsumed())
      ..add(const LoginEmailConfirmationNavigationConsumed()),
    verify: (bloc) {
      expect(bloc.state.loginContext, LoginContext.signUp);
      expect(bloc.state.obscurePassword, isFalse);
      expect(bloc.state.obscureConfirm, isFalse);
      expect(bloc.state.pendingDashboardNavigation, isFalse);
      expect(bloc.state.pendingEmailConfirmationNavigation, isFalse);
    },
  );

  blocTest<LoginViewModel, LoginState>(
    'generic auth error sets snackBarMessage',
    build: () {
      when(
        signIn.call(email: anyNamed('email'), password: anyNamed('password')),
      ).thenThrow(Exception('fail'));
      return LoginViewModel(LoginContext.signIn, signIn, signUp);
    },
    act: (bloc) => bloc
      ..add(const LoginEmailChanged('user@example.com'))
      ..add(const LoginPasswordChanged('any-password'))
      ..add(const LoginSubmitTapped()),
    verify: (bloc) {
      expect(bloc.state.snackBarMessage, isNotNull);
      expect(bloc.state.isLoading, isFalse);
    },
  );
}
