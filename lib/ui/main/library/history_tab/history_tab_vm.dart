//요청하면 책이랑 조인해서 DTO로 한 덩어리로 올 테니까 여기에 책 정보도 일단 넣어둬야 하나?
//바디에 lend랑 book이랑 별개로 있으면 각자 객체 생성해서 사용할텐데 어찌될지 모르니까 일단
//각각으로 해서
class Lend {
  String userId;
  String lendDate;
  String returnDate;
  bool returnState;

  String isbn13;
  String title;
  String cover;

  Lend({
    required this.userId,
    required this.lendDate,
    required this.returnDate,
    required this.returnState,
    required this.isbn13,
    required this.title,
    required this.cover,
  });
}

/*
class Book {
  String isbn13;
  String title;
  String cover;

  Book({
    required this.isbn13,
    required this.title,
    required this.cover,
  });
}
*/

List<Lend> lendList = [
  Lend(
    isbn13: '9791187011590',
    title: '책입니다1',
    cover:
        'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg',
    userId: '1',
    lendDate: '2024-10-13',
    returnDate: '2024-10-20',
    returnState: false,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀2',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '책 제목이 길다면?????????????????????????????????????????????',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀4',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀5',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀6',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀7',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀8',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
  Lend(
    isbn13: '9791187011590',
    title: '타이틀9',
    cover:
        'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg',
    userId: '1',
    lendDate: '2024-10-01',
    returnDate: '2024-10-08',
    returnState: true,
  ),
];
