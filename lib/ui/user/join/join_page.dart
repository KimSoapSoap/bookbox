import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/data/repository/user/user_repository.dart';
import 'package:bookbox/ui/_components/custom_text_form_field.dart';
import 'package:bookbox/ui/_components/default_layout.dart';
import 'package:bookbox/ui/user/components/msg.dart';
import 'package:bookbox/ui/user/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _formKey = GlobalKey<FormState>();
  String? msg;
  Color? color;
  bool idCheck = false;
  bool nickCheck = false;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _passwordFieldFocus = FocusNode();
  final FocusNode _passwordCheckFieldFocus = FocusNode();
  final FocusNode _mailFieldFocus = FocusNode();
  final FocusNode _phoneNumberFieldFocus = FocusNode();
  final userId = TextEditingController();
  final password = TextEditingController();
  final passwordCheck = TextEditingController();
  final nick = TextEditingController();
  final mail = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 포커스 리스너 공통 처리
    _addFocusListener(_passwordFieldFocus);
    _addFocusListener(_passwordCheckFieldFocus);
    _addFocusListener(_mailFieldFocus);
    _addFocusListener(_phoneNumberFieldFocus);
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
        // 여유를 위해 maxScrollExtent에 300을 더해 스크롤 위치 설정
        final bottomPosition = _scrollController.position.maxScrollExtent + 300;
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
    _passwordFieldFocus.dispose();
    _passwordCheckFieldFocus.dispose();
    _mailFieldFocus.dispose();
    _phoneNumberFieldFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Padding(
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

                  // 아이디 입력 필드 및 중복 체크 버튼
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: userId,
                          validator: '아이디가 입력되지 않았습니다.',
                          hintText: '아이디를 입력해주세요.',
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            // 아이디 중복 체크 확인
                            print(userId.text);
                            dynamic resp = await UserRepository.instance
                                .checkUsername(userId.text);
                            if (resp.data['msg'] != 200) {
                              print('닉네임 중복');
                            }
                            Logger().d("아이디 중복 아님");
                            idCheck = true;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SECONDARY_COLOR,
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
                          controller: nick,
                          validator: '닉네임이 입력되지 않았습니다.',
                          hintText: '닉네임을 입력해주세요.',
                          onChanged: (String value) {},
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // 닉네임 중복 체크 확인
                            print(nick.text);
                            nickCheck = true;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SECONDARY_COLOR,
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
                    controller: password,
                    focusNode: _passwordFieldFocus,
                    validator: '비밀번호가 입력되지 않았습니다.',
                    hintText: '비밀번호를 입력해주세요.',
                    obscureText: true,
                    //비번 입력창은 변경하면 메시지 지우기
                    onChanged: (String value) {
                      msg = '';
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: passwordCheck,
                    focusNode: _passwordCheckFieldFocus,
                    validator: '비밀번호 확인이 입력되지 않았습니다.',
                    hintText: '비밀번호를 다시 입력해주세요.',
                    onChanged: (String value) {
                      //비번 확인 입력시 비번 일치하면 메시지 출력
                      if (password.text == value) {
                        color = Colors.blue;
                        msg = '입력한 비밀번호가 일치합니다';
                        setState(() {});
                      } else {
                        msg = '';
                        setState(() {});
                      }
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: mail,
                    focusNode: _mailFieldFocus,
                    validator: '이메일이 입력되지 않았습니다.',
                    hintText: '이메일을 입력해주세요.',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: phoneNumber,
                    focusNode: _phoneNumberFieldFocus,
                    validator: '연락처가 입력되지 않았습니다.',
                    hintText: '연락처를 입력해주세요.',
                  ),
                  Msg(msg: msg, color: color),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        //입력 검증
                        if (_formKey.currentState!.validate()) {
                          //입력값이 존재하면 다음 로직 진행
                          // 유효성 검사
                          if (idCheck == false) {
                            msg = '아이디 중복체크를 해주세요';
                            setState(() {});
                            return;
                          }
                          if (nickCheck == false) {
                            msg = '닉네임 중복체크를 해주세요';
                            setState(() {});
                            return;
                          }

                          // 회원가입 로직
                          print(userId.text);
                          print(password.text);
                          print(nick.text);
                          print(mail.text);
                          print(phoneNumber.text);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ),
                          );
                        } else {
                          //입력 검증 실패
                          print('2');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SECONDARY_COLOR,
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
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => LoginPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(),
                      child: Text('이미 계정이 있으신가요? 로그인'),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        ));
  }
}
