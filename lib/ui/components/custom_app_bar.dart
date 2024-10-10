import 'package:bookbox/core/constants/size.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;

  const CustomAppBar({this.titleText = 'BookBox'});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 28, // 타이틀 크기 조정
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

    return AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: gap_s),
          Image.asset(
            "assets/logo.png",
            width: 40,
            height: 40,
          ),
          Spacer(),
          Text(
            '$titleText',
            style: titleStyle,
          ),
          Spacer(), // 오른쪽으로 밀기 위해 사용
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // 알림 클릭 시 행동
            },
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
