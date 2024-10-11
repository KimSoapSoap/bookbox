import 'package:bookbox/core/constants/color.dart';
import 'package:flutter/cupertino.dart';

class Msg extends StatelessWidget {
  final String? msg;
  final Color? color;

  Msg({this.msg, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(
          msg ?? '',
          style: TextStyle(color: color ?? ERROR_COLOR),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
