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
}
