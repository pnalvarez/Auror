/// Valores públicos do projeto Supabase usados no app (URL + chave publishable).
/// Prefira `--dart-define` em builds de produção e leia aqui via [String.fromEnvironment].
library;

abstract final class AurorSupabaseConstants {
  AurorSupabaseConstants._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://medeadsoqdzauixvqlcr.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_ALnsBT12AEDvbgnwD6eJXw_d4gmPYQs',
  );
}
