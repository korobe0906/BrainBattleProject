class AuthMeResponse {
  final String id;
  final String? email;
  final Map<String, dynamic>? profile;
  final Map<String, dynamic>? learnerProfile;
  final List<String> roles;

  AuthMeResponse({
    required this.id,
    required this.email,
    required this.profile,
    required this.learnerProfile,
    required this.roles,
  });

  factory AuthMeResponse.fromJson(Map<String, dynamic> json) {
    final userMap = (json['user'] as Map<String, dynamic>?) ?? json;
    final rawRoles = json['roles'];

    return AuthMeResponse(
      id: (userMap['id'] ?? '').toString(),
      email: userMap['email']?.toString(),
      profile: json['profile'] as Map<String, dynamic>?,
      learnerProfile: json['learnerProfile'] as Map<String, dynamic>?,
      roles: rawRoles is List
          ? rawRoles.map((e) => e.toString()).toList()
          : const <String>[],
    );
  }
}