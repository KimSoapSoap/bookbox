import 'package:bookbox/core/constants/color.dart';
import 'package:flutter/material.dart';

//외부에서 추가적으로 TextFormField마다 따로 정의해야 되는 것들은 파라미터로 정리
//공통적으로 똑같이 스타일링 하는 것들은 TextFormField 내부에다가 정의 했다.

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //기본은 UnderLineInputBorder();
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1.0,
    ));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할 때
      obscureText: obscureText,
      //위젯이 화면에 오는 순간 바로 focus 시켜주겠다는 것
      autofocus: autofocus,
      //값이 바뀔 때마다 실행되는 콜백
      //ctrl + click 해보면 무슨 타입을 받는지 알 수 있다.
      //필요할 때 옵션 넣어주면 됨
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        // 바로 적용되지 않는다. fiiled옵션의 boolean값에 따라 다름
        fillColor: INPUT_BG_COLOR,
        // true - 배경 있음 // false - 배경없음
        filled: true,
        //모든 Input 상태의 기본 스타일 세팅.
        //선택했을 때 따로 지정을 하기 위해서 baseBorder변수로 따로 뺐다.
        //이를 copyWith()를 사용해서 선택했을 때 바꿀 부분만 바꿔줄 것이다.
        border: baseBorder,
        //선택했을 때 테두리 설정. A.copyWith()는 A의 특성 그대로 유지
        //거기서 바꾸고 싶은 것만 바꿀 수 있다.
        focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
          // 결론적으로 baseBorder설정에서 색깔만 바꿈 -> 선택됐을 때 색 변경
          color: PRIMARY_COLOR,
        )),
      ),
    );
  }
}
