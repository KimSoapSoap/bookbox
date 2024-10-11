import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/ui/components/custom_text_form_field.dart';
import 'package:bookbox/ui/components/default_layout.dart';
import 'package:bookbox/ui/main/main_page.dart';
import 'package:bookbox/ui/user/components/msg.dart';
import 'package:bookbox/ui/user/join/join_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? msg;
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _idFieldFocus = FocusNode();
  final FocusNode _passwordFieldFocus = FocusNode();
  final userId = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 각각의 필드 포커스 시 스크롤 동작 설정
    _addFocusListener(_idFieldFocus);
    _addFocusListener(_passwordFieldFocus);
  }

  // FocusNode에 리스너 추가하는 공통 함수
  void _addFocusListener(FocusNode focusNode) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _scrollToTextBottom();
      }
    });
  }

  void _scrollToTextBottom() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        // 여유를 위해 maxScrollExtent에 100을 더해 스크롤 위치 설정
        final bottomPosition = _scrollController.position.maxScrollExtent + 100;
        _scrollController.animateTo(
          bottomPosition,
          duration: Duration(milliseconds: 500), // 0.5초 동안 스크롤 애니메이션
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    // 리스너 해제 및 리소스 정리
    _idFieldFocus.dispose();
    _passwordFieldFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
            controller: _scrollController,
            //키보드 올라왔을 때 ListView의 화면을 드래그 하면 키보드 사라짐
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
                    Image.asset(
                      'assets/logo.png',
                      //context가 이 위젯을 의미하는듯, 그것의 width 사이즈
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: userId,
                      focusNode: _idFieldFocus,
                      validator: '아이디가 입력되지 않았습니다.',
                      hintText: '아이디를 입력해주세요.',
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    CustomTextFormField(
                      controller: password,
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
                          //전송 로직
                          print(userId.text);
                          //입력 검증
                          if (_formKey.currentState!.validate()) {
                            //입력값이 존재하면 다음 로직 진행
                            // 유효성 검사

                            //로그인 할 때는 뒤로가기 안 남기도록.
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => MainPage(),
                              ),
                            );
                          } else {
                            //입력 검증 실패
                            print('2');
                          }
                          // end of if,
                        },
                        style: ElevatedButton.styleFrom(
                          //버전 업 되면서 styleFrom에서 primary대신 foregroundColor로
                          backgroundColor: PRIMARY_COLOR,
                        ),
                        child: Text('로그인',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          print(password.text);
                          //회원가입 할 때는 뒤로가기 남긴다.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => JoinPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: Text('회원가입'),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('환영합니다',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ));
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('아이디와 비밀번호를 입력해서 로그인 해주세요.\n오늘도 행복한 독서시간이 되길 :)',
        style: TextStyle(
          fontSize: 16,
          color: BODY_TEXT_COLOR,
        ));
  }
}
