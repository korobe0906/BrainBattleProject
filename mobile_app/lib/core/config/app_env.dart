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

  static const String learningApiBaseUrl = String.fromEnvironment(
    'LEARNING_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3001/api/learning',
  );

  static const String shortVideoApiBaseUrl = String.fromEnvironment(
    'SHORT_VIDEO_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3003/api/short-video',
  );

  static const String authCallbackUrl = String.fromEnvironment(
    'AUTH_CALLBACK_URL',
    defaultValue: 'brainbattle://auth-callback',
  );

  static const String resetPasswordUrl = String.fromEnvironment(
    'RESET_PASSWORD_URL',
    defaultValue: 'brainbattle://reset-password',
  );

  static const String appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  static bool get isProduction => appEnv == 'production';

  static bool get isDevMode => !isProduction;

  static void validate() {
    final missing = <String>[];

    if (supabaseUrl.isEmpty) missing.add('SUPABASE_URL');
    if (supabaseAnonKey.isEmpty) missing.add('SUPABASE_ANON_KEY');
    if (authApiBaseUrl.isEmpty) missing.add('AUTH_API_BASE_URL');
    if (battleApiBaseUrl.isEmpty) missing.add('BATTLE_API_BASE_URL');
    if (battleSocketUrl.isEmpty) missing.add('BATTLE_SOCKET_URL');

    if (missing.isNotEmpty) {
      throw StateError('Missing required config values: ${missing.join(', ')}');
    }
  }
}