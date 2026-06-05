import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../core/services/auth_session_service.dart';
import '../../../core/theme/theme_extensions.dart';
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
    final auth = context.authTokens.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = ProfileContent(
      loading: _loading,
      authContext: _authContext,
      onRefresh: _loadProfile,
      onLogout: _logout,
    );

    if (widget.embedded) return content;

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: app.backgroundPrimary,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'PROFILE',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: auth.accent,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadProfile,
            icon: Icon(Icons.refresh_rounded, color: app.textPrimary),
          ),
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () => BrainBattleApp.of(context).toggleTheme(),
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: app.textPrimary,
            ),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: Icon(Icons.logout_rounded, color: app.textPrimary),
          ),
        ],
      ),
      body: content,
    );
  }
}