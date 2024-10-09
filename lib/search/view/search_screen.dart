import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
