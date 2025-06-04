import 'package:chart/auth/view/signup_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/auth/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController.clear();
    passwordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('auth state build: ${ref.watch(authStateProvider).isLoggedIn}');
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

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
                    controller: emailController,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'password'),
                    controller: passwordController,
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        print(
                          'auth state try: ${ref.watch(authStateProvider).isLoggedIn}',
                        );

                        loginViewModel.saveLoginEmail(emailController.text);
                        final user = await loginViewModel.login(
                          emailController.text,
                          passwordController.text,
                        );
                        print('email: ${emailController.text}');
                        print('password: ${passwordController.text}');
                        print('loginstate: ${loginState.value}');

                        ref.read(authStateProvider.notifier).login(user);
                      } catch (err) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('로그인 실패'),
                            content: Text('아이디/비밀번호를 확인해주세요'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('확인'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('login'),
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
