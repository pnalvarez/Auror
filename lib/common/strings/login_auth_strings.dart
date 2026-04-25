/// Mensagens de autenticação (Supabase / GoTrue) para feedback na UI
/// (login, cadastro e encerrar sessão no perfil).
library;

const String loginAuthErrorInvalidCredentials =
    'E-mail ou senha incorretos. Verifique os dados e tente de novo.';

const String loginAuthErrorEmailExists =
    'Este e-mail já está cadastrado. Entre ou use outro e-mail.';

const String loginAuthErrorEmailNotConfirmed =
    'Confirme seu e-mail antes de entrar. Verifique a caixa de entrada e o spam.';

const String loginAuthErrorSignUpConfirmEmail =
    'Conta criada. Confirme seu e-mail para ativar o acesso e depois entre com sua senha.';

const String loginAuthErrorSignInAfterSignUpGeneric =
    'Conta criada, mas não foi possível entrar automaticamente. Tente entrar manualmente.';

const String loginAuthErrorSignupDisabled =
    'Novos cadastros estão desativados no momento. Tente mais tarde.';

const String loginAuthErrorUserBanned =
    'Esta conta foi desativada. Entre em contato com o suporte.';

const String loginAuthErrorRateLimit =
    'Muitas tentativas. Aguarde um pouco e tente novamente.';

const String loginAuthErrorWeakPassword =
    'Senha fraca. Use os requisitos indicados e tente de novo.';

const String loginAuthErrorNetwork =
    'Sem conexão ou o servidor não respondeu. Verifique a internet e tente de novo.';

const String loginAuthErrorServerConfig =
    'Não foi possível conectar ao serviço de login. Verifique a configuração do app.';

const String loginAuthErrorUnknown =
    'Não foi possível concluir a operação. Tente de novo em instantes.';

const String loginAuthErrorSignOutFailed =
    'Não foi possível encerrar a sessão. Tente novamente em instantes.';

const String loginAuthErrorSignOutSession =
    'Sessão inválida ou já encerrada. Atualize o app ou entre de novo.';
