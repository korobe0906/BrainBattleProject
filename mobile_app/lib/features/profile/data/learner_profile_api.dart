import 'package:dio/dio.dart';

import '../../../core/network/backend_api_client.dart';
import '../../auth/data/models/auth_me_response.dart';

class LearnerProfileApi {
  LearnerProfileApi._();

  static final LearnerProfileApi instance = LearnerProfileApi._();

  Future<AuthLearnerProfile> updateMe({
    required String goalType,
    required String currentLevel,
    required String targetLevel,
    required String nativeLanguage,
    required String targetLanguage,
    required List<String> focusSkills,
    required List<String> weakSkills,
  }) async {
    final Response response =
        await BackendApiClient.instance.authDio.patch(
      '/learner-profiles/me',
      data: {
        'goal_type': goalType,
        'current_level': currentLevel,
        'target_level': targetLevel,
        'native_language': nativeLanguage,
        'target_language': targetLanguage,
        'focus_skills': focusSkills,
        'weak_skills': weakSkills,
      },
    );

    return AuthLearnerProfile.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  Future<AuthLearnerProfile> completeOnboarding() async {
    final Response response = await BackendApiClient.instance.authDio.post(
      '/learner-profiles/me/complete-onboarding',
    );

    return AuthLearnerProfile.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}