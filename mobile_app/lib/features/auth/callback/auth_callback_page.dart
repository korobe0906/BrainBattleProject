import 'package:flutter/material.dart';

import '../login/login_page.dart';

class AuthCallbackPage extends StatefulWidget {
  const AuthCallbackPage({super.key});

  static const routeName = '/auth/callback';

  @override
  State<AuthCallbackPage> createState() => _AuthCallbackPageState();
}

class _AuthCallbackPageState extends State<AuthCallbackPage> {
  @override
  void initState() {
    super.initState();

    _handleCallback();
  }

  Future<void> _handleCallback() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    // 👉 Sau verify email → quay về login
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}