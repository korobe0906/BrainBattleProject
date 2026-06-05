import 'package:flutter/material.dart';

import '../../profile/ui/complete_profile_page.dart';
import '../../profile/ui/learner_profile_page.dart';
import '../../profile/ui/learning_goal_onboarding_page.dart';
import '../data/models/auth_me_response.dart';
import '../starter/starter_page.dart';

class AuthFlowRouter {
  AuthFlowRouter._();

  static void goByContext(
    BuildContext context,
    AuthMeResponse authContext,
  ) {
    if (authContext.needsProfileSetup) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        CompleteProfilePage.routeName,
        (route) => false,
        arguments: authContext,
      );
      return;
    }

    if (authContext.needsOnboarding) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        LearningGoalOnboardingPage.routeName,
        (route) => false,
        arguments: authContext,
      );
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      LearnerProfilePage.routeName,
      (route) => false,
    );
  }

  static void goToStarter(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      StarterPage.routeName,
      (route) => false,
    );
  }
}