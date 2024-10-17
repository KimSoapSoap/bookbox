import 'package:flutter/material.dart';

class LendCardItem extends StatelessWidget {
  final String isbn13;
  final String cover; // 이미지 URL
  final String title; // 책 제목
  final String returnDate;

  LendCardItem({
    required this.isbn13,
    required this.cover,
    required this.title,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 표시
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Image.network(
                width: double.infinity, // 부모 너비에 맞추기
                height: 160.0,
                cover, // 너비를 부모에 맞추기
                fit: BoxFit.cover, // 이미지가 잘리도록 설정
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), // 패딩 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '기한: ${returnDate}',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 제목 스타일
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
  Widget _author() {
    if (author == null) {
      return SizedBox.shrink();
    } else {
      return Text(
        author,
        style: TextStyle(color: Colors.grey),
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // 저자 스타일
      );
    }
  }
  */
