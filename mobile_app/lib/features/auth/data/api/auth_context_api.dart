import 'package:dio/dio.dart';

import '../../../../core/network/backend_api_client.dart';
import '../models/auth_me_response.dart';

class AuthContextApi {
  AuthContextApi._();

  static final AuthContextApi instance = AuthContextApi._();

  Future<AuthMeResponse> bootstrap() async {
    final Response response =
        await BackendApiClient.instance.authDio.post('/auth/bootstrap');

    return AuthMeResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  Future<AuthMeResponse> getMe() async {
    final Response response =
        await BackendApiClient.instance.authDio.get('/auth/me');

    return AuthMeResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}