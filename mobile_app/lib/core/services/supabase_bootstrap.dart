import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_env.dart';

class SupabaseBootstrap {
  SupabaseBootstrap._();

  static Future<void> initialize() async {
    debugPrint('SUPABASE: validate env');
    AppEnv.validate();

    debugPrint('SUPABASE: url=${AppEnv.supabaseUrl}');
    debugPrint('SUPABASE: authApiBaseUrl=${AppEnv.authApiBaseUrl}');
    debugPrint('SUPABASE: battleApiBaseUrl=${AppEnv.battleApiBaseUrl}');
    debugPrint('SUPABASE: anon key empty=${AppEnv.supabaseAnonKey.isEmpty}');

    await Supabase.initialize(
      url: AppEnv.supabaseUrl,
      anonKey: AppEnv.supabaseAnonKey,
    );

    debugPrint('SUPABASE: initialized');
  }
}