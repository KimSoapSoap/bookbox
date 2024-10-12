import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final List<ListTile> actions;
  final double width;
  final double height;
  final Color backgroundColor;
  final double opacity; // 투명도 설정 -> 기본 0.3
  final double borderRadius; // 모서리 둥글기 추가
  final Widget icon; // 아이콘을 커스터마이징할 수 있도록 필드 추가

  CustomFloatingButton({
    required this.actions,
    this.width = 30.0,
    this.height = 30.0,
    this.backgroundColor = const Color(0xFF7AB6FA),
    this.opacity = 0.3,
    this.borderRadius = 8.0, // 기본값으로 약간 둥글게 설정
    this.icon = const Icon(Icons.more_vert), // 기본 아이콘 설정
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true, // 안전 영역을 고려
            context: context,
            builder: (context) {
              return Wrap(
                children: actions,
              );
            },
          );
        },
        backgroundColor: backgroundColor.withOpacity(opacity),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // 모서리 반경 설정
        ),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
