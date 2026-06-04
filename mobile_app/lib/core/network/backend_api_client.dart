import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_env.dart';

class BackendApiClient {
  BackendApiClient._internal() {
    authDio = _createDio(AppEnv.authApiBaseUrl);
    battleDio = _createDio(AppEnv.battleApiBaseUrl);
    dio = battleDio;
  }

  late final Dio dio;
  late final Dio authDio;
  late final Dio battleDio;

  static final BackendApiClient instance = BackendApiClient._internal();

  Dio _createDio(String baseUrl) {
    final client = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: const <String, Object>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Supabase.instance.client.auth.currentSession?.accessToken;

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );

    return client;
  }
}