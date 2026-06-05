import 'package:flutter/material.dart';

import '../../../core/services/auth_session_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../../auth/data/api/auth_context_api.dart';
import '../../auth/data/models/auth_me_response.dart';
import '../../auth/login/login_page.dart';
import '../widgets/profile_content.dart';

class LearnerProfilePage extends StatefulWidget {
  const LearnerProfilePage({
    super.key,
    this.embedded = false,
  });

  static const routeName = '/learner-profile';

  final bool embedded;

  @override
  State<LearnerProfilePage> createState() => _LearnerProfilePageState();
}

class _LearnerProfilePageState extends State<LearnerProfilePage> {
  bool _loading = true;
  AuthMeResponse? _authContext;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);

    try {
      final data = await AuthContextApi.instance.getMe();
      if (!mounted) return;
      setState(() => _authContext = data);
    } catch (_) {
      await AuthSessionService.instance.signOut();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    setState(() => _loading = true);

    try {
      await AuthSessionService.instance.signOut();
    } finally {
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return NeonScaffold(
      title: 'Profile',
      subtitle: 'Account, learning profile and reward identity.',
      showBack: !widget.embedded,
      scrollable: false,
      padding: EdgeInsets.zero,
      actions: [
        IconButton(
          tooltip: 'Refresh',
          onPressed: _loadProfile,
          icon: Icon(Icons.refresh_rounded, color: app.textPrimary),
        ),
      ],
      child: ProfileContent(
        loading: _loading,
        authContext: _authContext,
        onRefresh: _loadProfile,
        onLogout: _logout,
      ),
    );
  }
}