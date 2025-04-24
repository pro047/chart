import 'dart:async';
import 'package:chart/auth/model/model/signup_model.dart';
import 'package:chart/auth/model/repository/signup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupViewModel extends AsyncNotifier<int?> {
  final SignupRepository _signuprepository = SignupRepository();

  @override
  FutureOr<int?> build() {
    // _signuprepository = ref.read(LoginRepositoryProvider);
    return null;
  }

  Future<void> signup(SignupModel signupModel) async {
    state = const AsyncLoading();

    try {
      final newUser = await _signuprepository.signup(signupModel);
      state = AsyncData(newUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final signupViewModelProvider = AsyncNotifierProvider<SignupViewModel, int?>(
  () {
    return SignupViewModel();
  },
);
