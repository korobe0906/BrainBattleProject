import 'package:flutter/foundation.dart';

import '../data/services/supabase_auth_service.dart';

class SignUpController {
  SignUpController({
    SupabaseAuthService? authService,
  }) : _authService = authService ?? SupabaseAuthService.instance;

  final loading = ValueNotifier<bool>(false);
  final error = ValueNotifier<String?>(null);

  final SupabaseAuthService _authService;

  String? get errorMessage => error.value;

  void dispose() {
    loading.dispose();
    error.dispose();
  }

  /// Sign up directly with Supabase.
  Future<bool> startRegistration({
    required String email,
    required String password,
    required String emailRedirectTo,
  }) async {
    loading.value = true;
    error.value = null;

    try {
      await _authService.signUp(
        email: email,
        password: password,
        emailRedirectTo: emailRedirectTo,
      );
      return true;
    } catch (e) {
      error.value = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      loading.value = false;
    }
  }

  /// Resend confirmation email in Supabase confirm-email flow.
  Future<bool> resendOtp({
    required String email,
    required String emailRedirectTo,
  }) async {
    loading.value = true;
    error.value = null;

    try {
      await _authService.resendSignupEmail(
        email: email,
        emailRedirectTo: emailRedirectTo,
      );
      return true;
    } catch (e) {
      error.value = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      loading.value = false;
    }
  }

  /// Legacy method kept only to avoid breaking old imports/usages.
  /// Current Supabase signup flow does not complete registration via OTP entry here.
  Future<bool> completeRegistration({
    required String email,
    required String otp,
    required String password,
    required String displayName,
  }) async {
    error.value =
        'This flow is no longer used. Please verify your email via the link sent to your inbox.';
    return false;
  }
}