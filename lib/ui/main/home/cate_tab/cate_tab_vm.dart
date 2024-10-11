// 1. 창고 (ViewModel)
// 2. 창고 데이터 (State)

// 3. 창고 관리자 (Provider)

class Book {
  String isbn13;
  String title;
  String author;
  String? description;
  int categoryId;
  String cover;

  Book({
    required this.isbn13,
    required this.title,
    required this.author,
    required this.description,
    required this.categoryId,
    required this.cover,
  });
}

List<Book> BookList = [
  Book(
      isbn13: '9791187011590',
      title: '데미안 (오리지널 초판본 표지디자인) - 최신 원전 완역본',
      author: '헤르만 헤세 (지은이), 이미영 (옮긴이), 김선형 (해설)',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg'),
  Book(
      isbn13: '9781234567890',
      title: '군주론',
      author: '제인 오스틴',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg'),
  Book(
      isbn13: '9791187011590',
      title: '데미안 (오리지널 초판본 표지디자인) - 최신 원전 완역본',
      author: '헤르만 헤세 (지은이), 이미영 (옮긴이), 김선형 (해설)',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg'),
  Book(
      isbn13: '9781234567890',
      title: '군주론',
      author: '제인 오스틴',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg'),
  Book(
      isbn13: '9791187011590',
      title: '데미안 (오리지널 초판본 표지디자인) - 최신 원전 완역본',
      author: '헤르만 헤세 (지은이), 이미영 (옮긴이), 김선형 (해설)',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg'),
  Book(
      isbn13: '9781234567890',
      title: '군주론',
      author: '제인 오스틴',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg'),
  Book(
      isbn13: '9791187011590',
      title: '데미안 (오리지널 초판본 표지디자인) - 최신 원전 완역본',
      author: '헤르만 헤세 (지은이), 이미영 (옮긴이), 김선형 (해설)',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/9871/8/cover200/k042535550_2.jpg'),
  Book(
      isbn13: '9781234567890',
      title: '군주론',
      author: '제인 오스틴',
      description:
          '‘영혼의 전기’로 소개되는 《데미안》은 깊이 있는 정신분석과 자기 탐구로 가시밭 같은 자아 성찰의 길을 섬세하게 그려낸 그의 대표작이다. 이 책을 1919년 오리지널 초판본의 우아한 표지로 다시 만나보자.',
      categoryId: 2105,
      cover:
          'https://image.aladin.co.kr/product/32585/48/cover200/k442935344_1.jpg'),
];
