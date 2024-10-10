import 'package:flutter/material.dart';

class CateTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Center(
        child: Text(
          '주제별',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
