import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/data/gm/session_gm.dart';
import 'package:bookbox/ui/_components/custom_text_form_field.dart';
import 'package:bookbox/ui/user/components/msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// LoginPage를 ConsumerWidget으로 변경
class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _idFieldFocus = FocusNode();
  final _passwordFieldFocus = FocusNode();
  final _userId = TextEditingController();
  final _password = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? msg;

    // Provider로부터 ScrollController, FocusNode, TextEditingController를 가져오기

    // 각각의 필드 포커스 시 스크롤 동작 설정
    _addFocusListener(_idFieldFocus, _scrollController);
    _addFocusListener(_passwordFieldFocus, _scrollController);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Title(),
                    _SubTitle(),
                    SizedBox(height: 20),
                    ColorFiltered(
                      colorFilter: isDarkMode
                          ? const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Colors.black87, BlendMode.srcIn),
                      child: Image.asset(
                        'assets/logo.png',
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _userId,
                      focusNode: _idFieldFocus,
                      validator: '아이디가 입력되지 않았습니다.',
                      hintText: '아이디를 입력해주세요.',
                    ),
                    SizedBox(height: 1),
                    CustomTextFormField(
                      controller: _password,
                      focusNode: _passwordFieldFocus,
                      validator: '비밀번호가 입력되지 않았습니다.',
                      hintText: '비밀번호를 입력해주세요.',
                      obscureText: true,
                    ),
                    Msg(msg: msg),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Logger().d(
                                "로그인 버튼 클릭됨 ${_userId.text}, ${_password.text}, sessionProvider: $sessionProvider");
                            ref.read(sessionProvider).login(
                                _userId.text.trim(), _password.text.trim());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SECONDARY_COLOR,
                        ),
                        child:
                            Text('로그인', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/join");
                        },
                        child: Text('회원가입'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FocusNode에 리스너 추가하는 공통 함수
  void _addFocusListener(
      FocusNode focusNode, ScrollController scrollController) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _scrollToTextBottom(scrollController);
      }
    });
  }

  void _scrollToTextBottom(ScrollController scrollController) {
    Future.delayed(Duration(milliseconds: 500), () {
      if (scrollController.hasClients) {
        final bottomPosition = scrollController.position.maxScrollExtent + 100;
        scrollController.animateTo(
          bottomPosition,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('환영합니다',
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500));
  }
}

class _SubTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('아이디와 비밀번호를 입력해서 로그인 해주세요.\n오늘도 행복한 독서시간이 되길 :)',
        style: TextStyle(fontSize: 16));
  }
}

final sessionProvider = StateProvider<SessionGM>((ref) {
  return SessionGM();
});
