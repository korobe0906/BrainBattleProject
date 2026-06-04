import '../config/app_env.dart';

String apiBase() {
  return AppEnv.authApiBaseUrl;
}

String battleApiBase() {
  return AppEnv.battleApiBaseUrl;
}

String battleSocketBase() {
  return AppEnv.battleSocketUrl;
}