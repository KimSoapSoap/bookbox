import 'package:flutter/material.dart';

class SettingLogOut extends StatelessWidget {
  final String username;
  final VoidCallback onLogout;

  const SettingLogOut({required this.username, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(username),
      trailing: ElevatedButton(
        onPressed: onLogout,
        child: Text('로그아웃'),
      ),
    );
  }
}
