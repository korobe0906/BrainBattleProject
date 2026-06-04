import 'config/app_env.dart';

/// Centralized API configuration.
///
/// Không hardcode LAN IP nữa.
/// Muốn đổi môi trường thì truyền bằng --dart-define.
class ApiConfig {
  static String get learningBaseUrl => AppEnv.learningApiBaseUrl;

  static String get shortVideoBaseUrl => AppEnv.shortVideoApiBaseUrl;

  @Deprecated('Use learningBaseUrl instead')
  static String get duoBaseUrl => learningBaseUrl.replaceAll('/learning', '/duo');
}