import 'package:chart/auth/model/model/auth_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthStateModel> {
  AuthStateNotifier() : super(AuthStateModel(isLoggedIn: false));

  void login() {
    state = AuthStateModel(isLoggedIn: true);
  }

  void logout() {
    state = AuthStateModel(isLoggedIn: false);
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthStateModel>(
      (ref) => AuthStateNotifier(),
    );
