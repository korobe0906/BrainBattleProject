class AppEnv {
  AppEnv._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  static const String authApiBaseUrl = String.fromEnvironment(
    'AUTH_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );

  static const String battleApiBaseUrl = String.fromEnvironment(
    'BATTLE_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3001/api',
  );

  static const String battleSocketUrl = String.fromEnvironment(
    'BATTLE_SOCKET_URL',
    defaultValue: 'http://10.0.2.2:3001',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: battleApiBaseUrl,
  );

  static const String authCallbackUrl = String.fromEnvironment(
    'AUTH_CALLBACK_URL',
    defaultValue: 'brainbattle://auth-callback',
  );

  static const String resetPasswordUrl = String.fromEnvironment(
    'RESET_PASSWORD_URL',
    defaultValue: 'brainbattle://reset-password',
  );

  static bool get isDevMode {
    const value = String.fromEnvironment('APP_ENV', defaultValue: 'development');
    return value != 'production';
  }

  static void validate() {
    final missing = <String>[];

    if (supabaseUrl.isEmpty) {
      missing.add('SUPABASE_URL');
    }

    if (supabaseAnonKey.isEmpty ||
        supabaseAnonKey == 'PASTE_YOUR_SUPABASE_ANON_KEY_HERE') {
      missing.add('SUPABASE_ANON_KEY');
    }

    if (authApiBaseUrl.isEmpty) {
      missing.add('AUTH_API_BASE_URL');
    }

    if (battleApiBaseUrl.isEmpty) {
      missing.add('BATTLE_API_BASE_URL');
    }

    if (battleSocketUrl.isEmpty) {
      missing.add('BATTLE_SOCKET_URL');
    }

    if (missing.isNotEmpty) {
      throw StateError(
        'Missing required config values: ${missing.join(', ')}',
      );
    }
  }
}