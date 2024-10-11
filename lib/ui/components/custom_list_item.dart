import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart'; // Assuming this contains the Book model
import 'package:flutter/material.dart';

class CateItem extends StatelessWidget {
  const CateItem({
    super.key,
    required this.theme,
    required this.book,
  });

  final TextTheme theme;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('책Id : ${book.isbn13}');
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[400]!), // 하단 경계 설정
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 제목 정렬
              children: [
                Image.network(
                  book.cover, // 이미지 URL (예시)
                  height: 150,
                  width: 100, // 이미지 너비를 전체로 설정
                  fit: BoxFit.cover, // 이미지 비율 유지
                ),
                const SizedBox(width: 8), // 이미지와 제목 간의 간격
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: theme.bodyLarge,
                      ),
                      const SizedBox(height: 4), // 저자와 설명 사이의 간격
                      Text(
                        book.description ?? '', // 설명 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4), // 제목과 저자 사이의 간격
                      Text(
                        book.author, // 저자 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
