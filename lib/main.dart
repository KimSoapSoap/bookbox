import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/admin/admin_page.dart';
import 'package:bookbox/ui/main/main_page.dart';
import 'package:bookbox/ui/user/join/join_page.dart';
import 'package:bookbox/ui/user/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 테마 상태를 가져옴
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: SplashPage(),
      home: MainPage(),
      routes: {
        "/login": (context) => const LoginPage(),
        "/join": (context) => const JoinPage(),
        "/home": (context) => MainPage(),
        "/admin": (context) => const AdminPage(),
      },

      theme: lightTheme(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode, // 테마 모드 설정
    );
  }
}
