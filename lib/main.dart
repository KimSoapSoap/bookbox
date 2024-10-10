import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/main/main_page.dart';
import 'package:bookbox/ui/user/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: SplashPage(),
      home: LoginPage(),
      theme: theme(),
    );
  }
}
