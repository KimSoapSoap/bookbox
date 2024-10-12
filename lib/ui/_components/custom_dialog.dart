import 'package:flutter/material.dart';

class CustomDialog {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  CustomDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text("확인"),
              onPressed: () {
                onConfirm(); // 확인 버튼 눌렀을 때 전달 받은 함수 실행
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text("취소"),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }
}

/*
 CustomDialog(
                            title: '반납 확인',
                            content: '$index번 책을 반납 하시겠습니까?',
                            onConfirm: () => {
                                  print("확인 선택시 실행 로직"),
                                }).show(context);
                      },
 */
