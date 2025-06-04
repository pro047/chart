import 'package:chart/auth/model/model/auth_state_model.dart';
import 'package:chart/auth/model/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthStateModel> {
  AuthStateNotifier() : super(AuthStateModel(isLoggedIn: false, user: null));

  void login(UserModel user) {
    state = AuthStateModel(isLoggedIn: true, user: user);
  }

  void logout() {
    state = AuthStateModel(isLoggedIn: false, user: null);
    print('logout 성공 : $state');
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthStateModel>(
      (ref) => AuthStateNotifier(),
    );
