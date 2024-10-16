import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:bookbox/ui/detail/detail_book_page.dart';
import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final dynamic book;
  final TextTheme theme;

  HomeListItem({
    required this.book,
    required this.theme,
  });

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
              color: Theme.of(context).colorScheme.background,
              border: Border(
                bottom: BorderSide(color: Colors.grey[400]!), // 하단 경계 설정
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 제목 정렬
              children: [
                Image.network(
                  book.cover, // 이미지 URL
                  height: 150,
                  width: 100, // 이미지 너비를 설정
                  fit: BoxFit.cover, // 이미지 비율 유지
                ),
                SizedBox(width: 8), // 이미지와 제목 간의 간격
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: Theme.of(context).textTheme.bodyLarge, // 책 제목
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4), // 저자와 설명 사이의 간격
                      Text(
                        book.description ?? '', // 설명 텍스트
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4), // 제목과 저자 사이의 간격
                      Text(
                        book.author, // 저자 텍스트
                        style: Theme.of(context).textTheme.bodyMedium,
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
