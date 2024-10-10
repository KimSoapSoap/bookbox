import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/core/default_layout.dart';
import 'package:bookbox/ui/components/custom_text_form_field.dart';
import 'package:bookbox/ui/main/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
            //키보드 올라왔을 때 ListView의 화면을 드래그 하면 키보드 사라짐
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  _SubTitle(),
                  SizedBox(height: 20),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    //contextt가 이 위젯을 의미하는듯, 그것의 width 사이즈
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: '아이디를 입력해주세요.',
                    onChanged: (String value) {},
                  ),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요.',
                    onChanged: (String value) {},
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      //전송 로직

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                      );
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
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: Text('회원가입'),
                  ),
                ],
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
