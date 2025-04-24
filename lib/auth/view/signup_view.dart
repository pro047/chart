import 'package:chart/auth/model/model/signup_model.dart';
import 'package:chart/auth/view_model/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  TextEditingController nameContoller = TextEditingController();

  @override
  void dispose() {
    emailContoller.dispose();
    passwordContoller.dispose();
    nameContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signupViewModelProvider);
    final signupViewModel = ref.read(signupViewModelProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
        Focus.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('signup')),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  controller: emailContoller,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'password'),
                  controller: passwordContoller,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'name'),
                  controller: nameContoller,
                ),
                TextButton(
                  onPressed: () async {
                    final newUser = SignupModel(
                      email: emailContoller.text,
                      password: passwordContoller.text,
                      name: nameContoller.text,
                    );
                    await signupViewModel.signup(newUser);
                    print("emailContoller.text: ${emailContoller.text}");
                    print("passwordContoller.text: ${passwordContoller.text}");
                    print("nameContoller.text: ${nameContoller.text}");
                    print("signupState: $signupState");
                    print("signupviewmodel: $signupViewModel");
                    Navigator.pushNamed(context, '/login');
                  },
                  child:
                      signupState.isLoading
                          ? CircularProgressIndicator()
                          : Text('회원가입'),
                ),
                if (signupState.hasError)
                  Text(
                    '로그인 실패 ${signupState.error}',
                    style: TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
