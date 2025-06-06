import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/auth/view_model/login_view_model.dart';

class LogoutDialog extends ConsumerStatefulWidget {
  const LogoutDialog({super.key});

  @override
  ConsumerState<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends ConsumerState<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('로그아웃'),
      content: Text('정말 로그아웃하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(loginViewModelProvider.notifier).logout();
            Navigator.pop(context);
          },
          child: Text('로그아웃'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
      ],
    );
  }
}
