import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  SupabaseAuthService._();

  static final SupabaseAuthService instance = SupabaseAuthService._();

  GoTrueClient get _auth => Supabase.instance.client.auth;

  Session? get currentSession => _auth.currentSession;
  User? get currentUser => _auth.currentUser;

  Stream<AuthState> get onAuthStateChange => _auth.onAuthStateChange;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String emailRedirectTo,
  }) async {
    return _auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: emailRedirectTo,
    );
  }

  Future<void> resendSignupEmail({
    required String email,
    required String emailRedirectTo,
  }) async {
    await _auth.resend(
      type: OtpType.signup,
      email: email,
      emailRedirectTo: emailRedirectTo,
    );
  }

  Future<void> sendPasswordResetEmail({
    required String email,
    required String redirectTo,
  }) async {
    await _auth.resetPasswordForEmail(
      email,
      redirectTo: redirectTo,
    );
  }

  Future<UserResponse> updatePassword({
    required String newPassword,
  }) async {
    return _auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}