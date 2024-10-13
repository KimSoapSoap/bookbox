import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? backgroundColor;

  const CustomActionButton({
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 45.0, // 기본 너비
      height: height ?? 30.0, // 기본 높이
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // 모서리를 살짝 둥글게 설정
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white, // 글자색 기본값
          ),
        ),
      ),
    );
  }
}
