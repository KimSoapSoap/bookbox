import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final List<ListTile> actions; // ListTile 리스트로 받기

  CustomFloatingButton({
    required this.actions, // 가변 인자처럼 사용 가능
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: actions, // 전달된 ListTile 리스트를 그대로 사용
            );
          },
        );
      },
      backgroundColor: Colors.blue,
      child: Icon(Icons.more_vert),
    );
  }
}
