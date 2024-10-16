import 'package:flutter/material.dart';
import 'package:bookbox/core/constants/color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
      ),
    );
  }
}
