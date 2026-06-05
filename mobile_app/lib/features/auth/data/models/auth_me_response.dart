class AuthMeResponse {
  final String userId;
  final String? email;
  final DateTime? emailConfirmedAt;
  final DateTime? lastSignInAt;
  final List<String> roles;
  final bool isAdmin;
  final bool isModerator;
  final bool isAuditor;
  final AuthProfile? profile;
  final AuthLearnerProfile? learnerProfile;
  final AuthSettings? settings;
  final List<AuthWallet> wallets;
  final bool needsProfileSetup;
  final bool needsOnboarding;

  const AuthMeResponse({
    required this.userId,
    required this.email,
    required this.emailConfirmedAt,
    required this.lastSignInAt,
    required this.roles,
    required this.isAdmin,
    required this.isModerator,
    required this.isAuditor,
    required this.profile,
    required this.learnerProfile,
    required this.settings,
    required this.wallets,
    required this.needsProfileSetup,
    required this.needsOnboarding,
  });

  factory AuthMeResponse.fromJson(Map<String, dynamic> json) {
    return AuthMeResponse(
      userId: json['user_id']?.toString() ?? '',
      email: json['email']?.toString(),
      emailConfirmedAt: _date(json['email_confirmed_at']),
      lastSignInAt: _date(json['last_sign_in_at']),
      roles: _stringList(json['roles']),
      isAdmin: json['is_admin'] == true,
      isModerator: json['is_moderator'] == true,
      isAuditor: json['is_auditor'] == true,
      profile: json['profile'] is Map
          ? AuthProfile.fromJson(Map<String, dynamic>.from(json['profile']))
          : null,
      learnerProfile: json['learner_profile'] is Map
          ? AuthLearnerProfile.fromJson(
              Map<String, dynamic>.from(json['learner_profile']),
            )
          : null,
      settings: json['settings'] is Map
          ? AuthSettings.fromJson(Map<String, dynamic>.from(json['settings']))
          : null,
      wallets: json['wallets'] is List
          ? (json['wallets'] as List)
              .whereType<Map>()
              .map(
                (item) => AuthWallet.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
          : const [],
      needsProfileSetup: json['needs_profile_setup'] == true,
      needsOnboarding: json['needs_onboarding'] == true,
    );
  }

  String get displayName {
    final name = profile?.displayName?.trim();
    if (name != null && name.isNotEmpty) return name;

    final username = profile?.username?.trim();
    if (username != null && username.isNotEmpty) return username;

    final mail = email?.trim();
    if (mail != null && mail.isNotEmpty) return mail.split('@').first;

    return 'Learner';
  }
}

class AuthProfile {
  final String id;
  final String? email;
  final String? username;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuthProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    required this.bio,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthProfile.fromJson(Map<String, dynamic> json) {
    return AuthProfile(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString(),
      username: json['username']?.toString(),
      displayName: json['display_name']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
      bio: json['bio']?.toString(),
      status: json['status']?.toString(),
      createdAt: _date(json['created_at']),
      updatedAt: _date(json['updated_at']),
    );
  }
}

class AuthLearnerProfile {
  final String userId;
  final String? goalType;
  final String? currentLevel;
  final String? targetLevel;
  final String? nativeLanguage;
  final String? targetLanguage;
  final List<String> focusSkills;
  final List<String> weakSkills;
  final bool onboardingCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuthLearnerProfile({
    required this.userId,
    required this.goalType,
    required this.currentLevel,
    required this.targetLevel,
    required this.nativeLanguage,
    required this.targetLanguage,
    required this.focusSkills,
    required this.weakSkills,
    required this.onboardingCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthLearnerProfile.fromJson(Map<String, dynamic> json) {
    return AuthLearnerProfile(
      userId: json['user_id']?.toString() ?? '',
      goalType: json['goal_type']?.toString(),
      currentLevel: json['current_level']?.toString(),
      targetLevel: json['target_level']?.toString(),
      nativeLanguage: json['native_language']?.toString(),
      targetLanguage: json['target_language']?.toString(),
      focusSkills: _stringList(json['focus_skills']),
      weakSkills: _stringList(json['weak_skills']),
      onboardingCompleted: json['onboarding_completed'] == true,
      createdAt: _date(json['created_at']),
      updatedAt: _date(json['updated_at']),
    );
  }
}

class AuthSettings {
  final String? timezone;
  final String? language;
  final bool notificationEnabled;

  const AuthSettings({
    required this.timezone,
    required this.language,
    required this.notificationEnabled,
  });

  factory AuthSettings.fromJson(Map<String, dynamic> json) {
    return AuthSettings(
      timezone: json['timezone']?.toString(),
      language: json['language']?.toString(),
      notificationEnabled: json['notification_enabled'] == true,
    );
  }
}

class AuthWallet {
  final String id;
  final String walletAddress;
  final String chain;
  final bool isPrimary;
  final DateTime? verifiedAt;
  final DateTime? createdAt;

  const AuthWallet({
    required this.id,
    required this.walletAddress,
    required this.chain,
    required this.isPrimary,
    required this.verifiedAt,
    required this.createdAt,
  });

  factory AuthWallet.fromJson(Map<String, dynamic> json) {
    return AuthWallet(
      id: json['id']?.toString() ?? '',
      walletAddress: json['wallet_address']?.toString() ?? '',
      chain: json['chain']?.toString() ?? '',
      isPrimary: json['is_primary'] == true,
      verifiedAt: _date(json['verified_at']),
      createdAt: _date(json['created_at']),
    );
  }
}

List<String> _stringList(dynamic value) {
  if (value is! List) return const [];
  return value.map((item) => item.toString()).toList();
}

DateTime? _date(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}