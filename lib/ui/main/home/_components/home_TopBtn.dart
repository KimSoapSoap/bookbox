import 'package:flutter/material.dart';

class ScrollToTopButton extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollToTopButton({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_upward),
      tooltip: '상단으로 가기',
      backgroundColor: Colors.blue, // 배경 색상
      foregroundColor: Colors.white, // 아이콘 색상
      elevation: 6, // 그림자 높이
      mini: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
      ),
    );
  }
}
