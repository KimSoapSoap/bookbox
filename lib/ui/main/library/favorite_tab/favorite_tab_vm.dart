import 'package:bookbox/ui/main/library/_components/library_abstract_book.dart';

class _Book extends LibraryAbstractBook {
  String isbn13;
  String title;
  String? author;
  String? description;
  String cover;
  int categoryId;
  bool? lendStatus;
  int? reservationCount;

  _Book({
    required this.isbn13,
    required this.title,
    required this.author,
    required this.description,
    required this.categoryId,
    required this.cover,
    this.lendStatus = false,
    this.reservationCount = 0,
  });
}

List<_Book> bookList = [
  _Book(
      lendStatus: true,
      reservationCount: 3,
      isbn13: '9791187011590',
      title: '테스트용',
      author: '헤르만 헤세 (지은이), 이미영 (옮긴이), 김선형 (해설)',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg'),
];
