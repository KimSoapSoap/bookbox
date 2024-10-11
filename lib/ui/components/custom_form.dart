import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final Widget child;
  final _formKey = GlobalKey<FormState>(); // 1. 글로벌 key

  CustomForm({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // 2. 글로벌 key를 Form 태그에 연결하여 해당 key로 Form의 상태를 관리할 수 있다.
      key: _formKey,
      child: child,
    );
  }
}
