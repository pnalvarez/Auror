import 'package:auror/common/designsystem/atoms/colors/colors.dart';
import 'package:auror/common/designsystem/atoms/spacing/radius.dart';
import 'package:auror/common/designsystem/atoms/spacing/spacings.dart';
import 'package:auror/common/designsystem/atoms/typography/typography.dart';
import 'package:auror/common/designsystem/molecules/buttons/action_buttons.dart';
import 'package:auror/common/designsystem/molecules/buttons/button_brand.dart';
import 'package:auror/common/designsystem/molecules/inputfields/input_field.dart';
import 'package:auror/common/designsystem/theme/main_launch_dark_theme.dart';
import 'package:auror/common/strings/login_strings.dart';
import 'package:auror/layers/presentation/screens/login/login_context.dart';
import 'package:auror/layers/presentation/screens/login/login_event.dart';
import 'package:auror/layers/presentation/screens/login/login_state.dart';
import 'package:auror/layers/presentation/screens/login/login_validators.dart';
import 'package:auror/layers/presentation/screens/login/login_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.loginContext});

  final LoginContext loginContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginViewModel(loginContext: loginContext),
      child: Theme(data: mainLaunchDarkTheme(), child: const _LoginScaffold()),
    );
  }
}

class _LoginScaffold extends StatefulWidget {
  const _LoginScaffold();

  @override
  State<_LoginScaffold> createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<_LoginScaffold> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _nameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _confirmFocus;

  void _onFieldFocusChanged() {
    if (mounted) setState(() {});
  }

  void _showPasswordRequirementsDialog(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: scheme.surfaceContainerHigh,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.l),
            side: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
          ),
          title: Text(
            loginPasswordRequirementsTitle,
            style: headlineS.copyWith(color: scheme.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PasswordReqBullet(
                scheme: scheme,
                text: loginPasswordRequirementMinLength,
              ),
              _PasswordReqBullet(
                scheme: scheme,
                text: loginPasswordRequirementUppercase,
              ),
              _PasswordReqBullet(
                scheme: scheme,
                text: loginPasswordRequirementDigit,
              ),
              _PasswordReqBullet(
                scheme: scheme,
                text: loginPasswordRequirementSpecial,
              ),
            ],
          ),
          actions: [
            Center(
              child: PrimaryButton(
                label: loginPasswordRequirementsClose,
                action: Navigator.of(ctx).pop,
                isExpanded: true,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Hides inline errors while the field is focused.
  String? _shownError(FocusNode focus, String? message) {
    if (focus.hasFocus) return null;
    return message;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameFocus = FocusNode()..addListener(_onFieldFocusChanged);
    _emailFocus = FocusNode()..addListener(_onFieldFocusChanged);
    _passwordFocus = FocusNode()..addListener(_onFieldFocusChanged);
    _confirmFocus = FocusNode()..addListener(_onFieldFocusChanged);
  }

  @override
  void dispose() {
    _nameFocus.removeListener(_onFieldFocusChanged);
    _emailFocus.removeListener(_onFieldFocusChanged);
    _passwordFocus.removeListener(_onFieldFocusChanged);
    _confirmFocus.removeListener(_onFieldFocusChanged);

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = AppColors.Inverse.inversePrimary;
    final vm = context.read<LoginViewModel>();

    return BlocListener<LoginViewModel, LoginState>(
      listenWhen: (previous, current) =>
          previous.loginContext != current.loginContext,
      listener: (context, state) {
        _nameController.clear();
        _confirmPasswordController.clear();
      },
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacings.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => context.router.popUntilRoot(),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacings.m),
                Text(
                  loginBrandTitle,
                  textAlign: TextAlign.center,
                  style: headlineL.copyWith(color: accent),
                ),
                const SizedBox(height: AppSpacings.m),
                BlocSelector<LoginViewModel, LoginState, bool>(
                  selector: (s) => s.isSignUp,
                  builder: (context, isSignUp) {
                    return Text(
                      isSignUp ? loginSubtitleSignUp : loginSubtitleSignIn,
                      textAlign: TextAlign.center,
                      style: body2Light.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacings.xl3),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(AppRadius.l),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacings.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocSelector<LoginViewModel, LoginState, bool>(
                          selector: (s) => s.isSignUp,
                          builder: (context, isSignUp) {
                            if (!isSignUp) return const SizedBox.shrink();
                            return BlocSelector<
                              LoginViewModel,
                              LoginState,
                              String
                            >(
                              selector: (s) => s.name,
                              builder: (context, name) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    InputField(
                                      label: loginLabelName,
                                      controller: _nameController,
                                      focusNode: _nameFocus,
                                      placeholder: loginPlaceholderName,
                                      appearance: InputFieldAppearance.theme,
                                      errorMessage: _shownError(
                                        _nameFocus,
                                        loginNameError(name),
                                      ),
                                      onChanged: (v) =>
                                          vm.add(LoginEvent.nameChanged(v)),
                                    ),
                                    const SizedBox(height: AppSpacings.l),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        BlocSelector<LoginViewModel, LoginState, String>(
                          selector: (s) => s.email,
                          builder: (context, email) {
                            return InputField(
                              label: loginLabelEmail,
                              controller: _emailController,
                              focusNode: _emailFocus,
                              placeholder: loginPlaceholderEmail,
                              keyboardType: TextInputType.emailAddress,
                              appearance: InputFieldAppearance.theme,
                              errorMessage: _shownError(
                                _emailFocus,
                                loginEmailError(email),
                              ),
                              onChanged: (v) =>
                                  vm.add(LoginEvent.emailChanged(v)),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacings.l),
                        BlocSelector<
                          LoginViewModel,
                          LoginState,
                          (bool, String, bool)
                        >(
                          selector: (s) =>
                              (s.obscurePassword, s.password, s.isSignUp),
                          builder: (context, data) {
                            final (obscurePassword, password, isSignUp) = data;
                            return InputField(
                              label: loginLabelPassword,
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              placeholder: loginPlaceholderPassword,
                              obscureText: obscurePassword,
                              appearance: InputFieldAppearance.theme,
                              infoIcon: true,
                              onInfoTap: () =>
                                  _showPasswordRequirementsDialog(context),
                              errorMessage: _shownError(
                                _passwordFocus,
                                loginPasswordError(
                                  password,
                                  isSignUp: isSignUp,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => vm.add(
                                  const LoginEvent.passwordVisibilityToggled(),
                                ),
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              onChanged: (v) =>
                                  vm.add(LoginEvent.passwordChanged(v)),
                            );
                          },
                        ),
                        BlocSelector<LoginViewModel, LoginState, bool>(
                          selector: (s) => s.isSignUp,
                          builder: (context, isSignUp) {
                            if (!isSignUp) return const SizedBox.shrink();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: AppSpacings.l),
                                BlocSelector<
                                  LoginViewModel,
                                  LoginState,
                                  (bool, String, String)
                                >(
                                  selector: (s) => (
                                    s.obscureConfirm,
                                    s.confirmPassword,
                                    s.password,
                                  ),
                                  builder: (context, data) {
                                    final (obscureConfirm, confirm, password) =
                                        data;
                                    return InputField(
                                      label: loginLabelConfirmPassword,
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmFocus,
                                      placeholder: loginPlaceholderPassword,
                                      obscureText: obscureConfirm,
                                      appearance: InputFieldAppearance.theme,
                                      infoIcon: true,
                                      onInfoTap: () =>
                                          _showPasswordRequirementsDialog(
                                            context,
                                          ),
                                      errorMessage: _shownError(
                                        _confirmFocus,
                                        loginConfirmPasswordError(
                                          confirm,
                                          password,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () => vm.add(
                                          const LoginEvent.confirmPasswordVisibilityToggled(),
                                        ),
                                        icon: Icon(
                                          obscureConfirm
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: scheme.onSurfaceVariant,
                                        ),
                                      ),
                                      onChanged: (v) => vm.add(
                                        LoginEvent.confirmPasswordChanged(v),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacings.xl2),
                        BlocSelector<LoginViewModel, LoginState, (bool, bool)>(
                          selector: (s) => (s.canSubmit, s.isSignUp),
                          builder: (context, tuple) {
                            final (canSubmit, isSignUp) = tuple;
                            return PrimaryButton(
                              label: isSignUp ? loginCtaSignUp : loginCtaSignIn,
                              brand: ButtonBrand.primary,
                              enabled: canSubmit,
                              action: () =>
                                  vm.add(const LoginEvent.submitTapped()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacings.xl2),
                BlocSelector<LoginViewModel, LoginState, bool>(
                  selector: (s) => s.isSignUp,
                  builder: (context, isSignUp) {
                    final footerPrefix = isSignUp
                        ? loginFooterHasAccount
                        : loginFooterNoAccount;
                    final footerLink = isSignUp
                        ? loginFooterSignIn
                        : loginFooterCreateAccount;
                    return Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            footerPrefix,
                            style: body4Light.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final next = isSignUp
                                  ? LoginContext.signIn
                                  : LoginContext.signUp;
                              vm.add(LoginEvent.loginContextChanged(next));
                            },
                            child: Text(
                              footerLink,
                              style: body4Light.copyWith(
                                color: accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacings.xl2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordReqBullet extends StatelessWidget {
  const _PasswordReqBullet({required this.scheme, required this.text});

  final ColorScheme scheme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacings.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: body3Light.copyWith(color: scheme.onSurface)),
          Expanded(
            child: Text(
              text,
              style: body3Light.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
