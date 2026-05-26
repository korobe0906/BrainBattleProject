import '../data/api/auth_context_api.dart';
import '../data/models/auth_me_response.dart';
import '../data/services/supabase_auth_service.dart';

class LoginRepository {
  LoginRepository({
    SupabaseAuthService? authService,
    AuthContextApi? authContextApi,
  })  : _authService = authService ?? SupabaseAuthService.instance,
        _authContextApi = authContextApi ?? AuthContextApi.instance;

  final SupabaseAuthService _authService;
  final AuthContextApi _authContextApi;

  /// Sign in with Supabase, then verify/bootstrap current auth context
  /// from backend `/auth/me`.
  Future<AuthMeResponse> login(String email, String password) async {
    await _authService.signIn(
      email: email,
      password: password,
    );

    return _authContextApi.getMe();
  }
}