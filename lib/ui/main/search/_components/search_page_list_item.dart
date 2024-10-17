import 'package:flutter/material.dart';

class SearchPageListItem extends StatelessWidget {
  final TextTheme theme;
  final _Book book;

  const SearchPageListItem({
    super.key,
    required this.theme,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('책Id : ${book.isbn13}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              book.cover, // 이미지 URL
              height: 80,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12), // 이미지와 텍스트 간 간격
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: theme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '저자: ${book.author}',
                    style: theme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '출판사: ${book.publisher}',
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
    );
  }
}

class _Book {
  String isbn13;
  String title;
  String author;
  String publisher;
  String cover;
  String categoryId;

  _Book({
    required this.isbn13,
    required this.title,
    required this.author,
    required this.publisher,
    required this.cover,
    required this.categoryId,
  });

  //String returnDate;

  _Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.author = map['author'],
        this.publisher = map['publisher'],
        this.categoryId = map['categoryId'],
        this.cover = map['cover'];
}
