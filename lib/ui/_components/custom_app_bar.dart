import 'package:bookbox/core/constants/size.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;

  const CustomAppBar({this.titleText = 'BookBox'});

  @override
  Widget build(BuildContext context) {
    // 현재 테마가 다크 모드인지 확인
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final titleStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 28, // 타이틀 크기 조정
          fontWeight: FontWeight.bold,
        );

    return AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: gap_s),
          //다크모드, 라이트모드시 아이콘 이미지 컬러 필터
          ColorFiltered(
            colorFilter: isDarkMode
                ? const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn) // 다크 모드 시 색상 변경
                : const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            // 라이트 모드 시 색상 변경 없음
            child: Image.asset(
              "assets/logo.png",
              width: 40,
              height: 40,
            ),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
