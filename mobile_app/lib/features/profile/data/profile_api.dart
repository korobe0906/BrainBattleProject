import 'package:dio/dio.dart';

import '../../../core/network/backend_api_client.dart';
import '../../auth/data/models/auth_me_response.dart';

class ProfileApi {
  ProfileApi._();

  static final ProfileApi instance = ProfileApi._();

  Future<AuthProfile> getMe() async {
    final Response response =
        await BackendApiClient.instance.authDio.get('/profiles/me');

    return AuthProfile.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  Future<AuthProfile> updateMe({
    required String username,
    required String displayName,
    String? avatarUrl,
    String? bio,
  }) async {
    final Response response = await BackendApiClient.instance.authDio.patch(
      '/profiles/me',
      data: {
        'username': username,
        'display_name': displayName,
        'avatar_url': avatarUrl,
        'bio': bio,
      },
    );

    return AuthProfile.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}