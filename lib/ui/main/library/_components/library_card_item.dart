import 'package:flutter/material.dart';

class LibraryCardItem extends StatelessWidget {
  final String cover; // 이미지 URL
  final String title; // 책 제목
  final String? author; // 저자
  final String? returnDate;

  LibraryCardItem({
    required this.cover,
    required this.title,
    this.returnDate = '24-10-18',
    this.author,
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
                  '기한: ${returnDate!}',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 제목 스타일
                ),

                //저자 입력 안 하면 생략
                _author(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _author() {
    if (author == null) {
      return SizedBox.shrink();
    } else {
      return Text(
        author!,
        style: TextStyle(color: Colors.grey),
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // 저자 스타일
      );
    }
  }
}
