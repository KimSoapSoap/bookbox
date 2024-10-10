import 'package:flutter/material.dart';

class RecommendTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[100],
      child: Center(
        child: Text(
          '내서재',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
