import 'package:flutter/foundation.dart';

import '../data/models/auth_me_response.dart';
import 'login_repository.dart';

class LoginController {
  LoginController({LoginRepository? repo}) {
    _repo = repo ?? LoginRepository();
  }

  final loading = ValueNotifier<bool>(false);
  final error = ValueNotifier<String?>(null);
  final obscurePassword = ValueNotifier<bool>(true);

  late final LoginRepository _repo;

  AuthMeResponse? _lastAuthMe;
  AuthMeResponse? get lastAuthMe => _lastAuthMe;

  Future<bool> login(String email, String password) async {
    try {
      loading.value = true;
      error.value = null;

      _lastAuthMe = await _repo.login(email, password);
      return true;
    } catch (e) {
      error.value = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Login failed';
      return false;
    } finally {
      loading.value = false;
    }
  }

  void togglePassword() => obscurePassword.value = !obscurePassword.value;

  void dispose() {
    loading.dispose();
    error.dispose();
    obscurePassword.dispose();
  }
}