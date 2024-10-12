import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent[100],
      child: Center(
        child: Text(
          '서재탭3',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
