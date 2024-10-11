import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("검색 그림");
    return Container(
      color: Colors.redAccent[100],
      child: Center(
        child: Text(
          '검색',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
