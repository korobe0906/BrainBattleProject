class AppEnv {
  AppEnv._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://cenfiargplvysqpalcja.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlbmZpYXJncGx2eXNxcGFsY2phIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU5MDAyODcsImV4cCI6MjA5MTQ3NjI4N30.kig_YLey-Zr9nv_Hh5PxPzPS18GelD013Q5yT9NQIMI',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.169:3000',
  );

  static const String authCallbackUrl = String.fromEnvironment(
    'AUTH_CALLBACK_URL',
    defaultValue: 'brainbattle://auth-callback',
  );

  static const String resetPasswordUrl = String.fromEnvironment(
    'RESET_PASSWORD_URL',
    defaultValue: 'brainbattle://reset-password',
  );

  static void validate() {
    final missing = <String>[];

    if (supabaseUrl.isEmpty) missing.add('SUPABASE_URL');
    if (supabaseAnonKey.isEmpty ||
        supabaseAnonKey == 'PASTE_YOUR_SUPABASE_ANON_KEY_HERE') {
      missing.add('SUPABASE_ANON_KEY');
    }
    if (apiBaseUrl.isEmpty) missing.add('API_BASE_URL');

    if (missing.isNotEmpty) {
      throw StateError(
        'Missing required config values: ${missing.join(', ')}',
      );
    }
  }
}