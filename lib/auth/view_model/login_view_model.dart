import 'dart:async';
import 'package:chart/auth/model/model/user_model.dart';
import 'package:chart/auth/model/repository/login_repository.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends AsyncNotifier<UserModel?> {
  final LoginRepository _loginRepository = LoginRepository();

  @override
  FutureOr<UserModel?> build() {
    // _loginRepository = ref.read(LoginRepositoryProvider);
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    try {
      final user = await _loginRepository.login(email, password);
      state = AsyncData(user);
      ref.read(authStateProvider.notifier).login();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> saveLoginEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedEmail', email);
    // ignore: avoid_print
    print('loggedEmail : ${prefs.getString('loggedEmail')}');
  }
}

final loginViewModelProvider =
    AsyncNotifierProvider<LoginViewModel, UserModel?>(() {
      return LoginViewModel();
    });
