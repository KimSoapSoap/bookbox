import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/data/gm/session_gm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// opacity 상태를 관리하는 StateProvider
final opacityProvider = StateProvider<double>((ref) => 0.0);

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재의 opacity 값을 읽음
    final _opacity = ref.watch(opacityProvider);

    // 500ms 후에 opacity 상태 변경
    Future.delayed(Duration(milliseconds: 500), () {
      ref.read(opacityProvider.notifier).state = 1.0;
    });

// 3초 후에 메인 페이지로 이동
    Future.delayed(Duration(seconds: 1), () {
      ref.read(sessionProvider).autoLogin();
    });

    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 200,
                height: 200,
              ),
              SizedBox(height: gap_s),
              Text(
                "BookBox",
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
