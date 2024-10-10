import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/ui/components/custom_text_form_field.dart';
import 'package:bookbox/ui/components/default_layout.dart';
import 'package:bookbox/ui/main/main_page.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  _SubTitle(),
                  SizedBox(height: 20),

                  // 아이디 입력 필드 및 중복 체크 버튼
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: '아이디를 입력해주세요.',
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // 아이디 중복 체크 로직
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PRIMARY_COLOR,
                          ),
                          child: Text(
                            '중복체크',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // 닉네임 입력 필드 및 중복 체크 버튼
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: '닉네임을 입력해주세요.',
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // 닉네임 중복 체크 로직
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PRIMARY_COLOR,
                          ),
                          child: Text(
                            '중복체크',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요.',
                    onChanged: (String value) {},
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: '비밀번호를 다시 입력해주세요.',
                    onChanged: (String value) {},
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: '이메일을 입력해주세요.',
                    onChanged: (String value) {},
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: '폰 번호를 입력해주세요.',
                    onChanged: (String value) {},
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        // 회원가입 로직
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => MainPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        // 이미 계정이 있다면 로그인 페이지로 이동
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: Text('이미 계정이 있으신가요? 로그인'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('회원가입',
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
    return Text('회원 정보를 입력해 주세요.\n즐거운 독서 시간을 만들어 드립니다 :)',
        style: TextStyle(
          fontSize: 16,
          color: BODY_TEXT_COLOR,
        ));
  }
}
