import 'package:bookbox/core/constants/color.dart';
import 'package:flutter/cupertino.dart';

class ErrMsg extends StatelessWidget {
  final String? msg;

  ErrMsg({this.msg, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(
          '$msg' ?? '',
          style: TextStyle(color: ERROR_COLOR),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
