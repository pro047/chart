import 'dart:async';
import 'package:chart/auth/model/model/user_model.dart';
import 'package:chart/auth/model/repository/login_repository.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/ui/provider/tab_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends AsyncNotifier<UserModel?> {
  final LoginRepository _loginRepository = LoginRepository();

  @override
  FutureOr<UserModel?> build() {
    // _loginRepository = ref.read(LoginRepositoryProvider);
    return null;
  }

  Future<UserModel> login(String email, String password) async {
    state = const AsyncLoading();

    try {
      final user = await _loginRepository.login(email, password);
      state = AsyncData(user);
      ref.read(authStateProvider.notifier).login(user);
      ref.read(currentTabProvider.notifier).state = 0;
      return user;
    } catch (e, st) {
      state = AsyncError(e, st);
      throw Exception('login failed');
    }
  }

  Future<void> logout() async {
    state = const AsyncData(null);
    ref.read(authStateProvider.notifier).logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedUserId');
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('loggedUserId', userId);
    // ignore: avoid_print
    print('loggedUserId : ${prefs.getInt('loggedUserId')}');
  }
}

final loginViewModelProvider =
    AsyncNotifierProvider<LoginViewModel, UserModel?>(() {
      return LoginViewModel();
    });
