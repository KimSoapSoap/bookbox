import 'package:flutter/material.dart';

class SettingRow extends StatelessWidget {
  final String title;
  final Widget rightWidget;

  const SettingRow({required this.title, required this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: rightWidget,
    );
  }
}
