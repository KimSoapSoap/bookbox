import 'package:bookbox/ui/_components/book_base.dart';

class Book extends BookBase {
  @override
  String isbn13;
  @override
  String title;
  @override
  String author;
  @override
  String cover;

  String? publisher;
  String? pubDate;
  final int categoryId;

  Book({
    required this.isbn13,
    required this.title,
    required this.author,
    required this.categoryId,
    required this.cover,
    required this.publisher,
    required this.pubDate,
  });
}

List<Book> bookList = [
  for (int i = 1; i <= 30; i++)
    Book(
        isbn13: '9791187011590',
        title: '테스트 $i',
        author: '헤르만 헤세 (지은이), 이미영 (옮긴이), 김선형 (해설)',
        publisher: 'green콤퓨타',
        categoryId: 2105,
        pubDate: '2024-10-01',
        cover:
            'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg'),
];
