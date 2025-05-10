import 'package:chart/auth/view/signup_view.dart';
import 'package:chart/auth/view_model/login_view_model.dart';
import 'package:chart/ui/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();

  @override
  void dispose() {
    emailContoller.dispose();
    passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () {
        Focus.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('login')),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
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
                  loginState.isLoading
                      ? CircularProgressIndicator()
                      : TextButton(
                        onPressed: () async {
                          loginViewModel.saveLoginEmail(emailContoller.text);
                          if (!loginState.hasError) {
                            await loginViewModel.login(
                              emailContoller.text,
                              passwordContoller.text,
                            );
                            print('email: ${emailContoller.text}');
                            print('password: ${passwordContoller.text}');
                            print('loginstate: $loginState');
                            Navigator.of(
                              context,
                            ).push(MaterialPageRoute(builder: (_) => Layout()));
                          }
                        },
                        child: Text('login'),
                      ),
                  if (loginState.hasError)
                    Text(
                      '로그인 실패 ${loginState.error}',
                      style: TextStyle(color: Colors.black),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => SignupView()));
                    },
                    child: Text('signup'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
