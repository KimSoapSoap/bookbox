import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("셋팅 그림");
    return Container(
      color: Colors.redAccent[100],
      child: Center(
        child: Text(
          '설정',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
