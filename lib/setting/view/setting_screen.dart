import 'package:bookbox/commons/layout/default_layout.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
