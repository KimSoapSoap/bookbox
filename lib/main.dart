import 'package:bookbox/commons/view/root_tab.dart';
import 'package:bookbox/styles.dart';
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
      home: RootTab(),
      theme: theme(),
    );
  }
}
