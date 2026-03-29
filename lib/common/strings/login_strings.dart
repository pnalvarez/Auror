/// Copy for the login / sign-up screen.
library;

const String loginBrandTitle = 'Auror';

const String loginSubtitleSignIn = 'Entre para continuar aprendendo';
const String loginSubtitleSignUp = 'Crie sua conta para começar';

const String loginLabelName = 'Nome';
const String loginLabelEmail = 'E-mail';
const String loginLabelPassword = 'Senha';
const String loginLabelConfirmPassword = 'Confirmar senha';

const String loginPlaceholderName = 'Seu nome';
const String loginPlaceholderEmail = 'seu@email.com';
const String loginPlaceholderPassword = '••••••••';

const String loginCtaSignIn = 'Entrar';
const String loginCtaSignUp = 'Criar conta';

const String loginFooterNoAccount = 'Não tem conta? ';
const String loginFooterCreateAccount = 'Criar conta';

const String loginFooterHasAccount = 'Já tem conta? ';
const String loginFooterSignIn = 'Entrar';

/// Inline validation (shown only when the field is non-empty but invalid).
const String loginErrorEmailInvalid = 'E-mail inválido.';

const String loginErrorNameWhitespace =
    'Use um nome com pelo menos um caractere visível.';

/// Sign-up password rules (8+ chars, uppercase, digit, special).
const String loginErrorPasswordRequirements =
    'Use 8+ caracteres, 1 maiúscula, 1 número e 1 caractere especial.';

const String loginErrorPasswordMismatch = 'As senhas não conferem.';

/// Sign-in: password has characters but no non-whitespace content.
const String loginErrorPasswordWhitespace =
    'A senha não pode ser só espaços.';
