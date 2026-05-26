import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSessionService {
  AuthSessionService._();

  static final AuthSessionService instance = AuthSessionService._();

  GoTrueClient get _auth => Supabase.instance.client.auth;

  Session? get currentSession => _auth.currentSession;
  User? get currentUser => _auth.currentUser;

  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;

  bool get hasSession => currentSession != null;

  bool get hasValidLookingSession {
    final session = currentSession;
    if (session == null) return false;
    return !session.isExpired;
  }

  String? get accessToken => currentSession?.accessToken;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}