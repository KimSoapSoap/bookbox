import 'package:bookbox/data/post_repository.dart';
import 'package:bookbox/ui/_components/custom_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고(ViewModel)
class PostListVM extends StateNotifier<PostListModel?> {
  PostListVM(super.state);

  //Spring에서 service같은 부분이다. 여기서 비즈니스 로직을 처리해준다.
  Future<void> notifyInit() async {
    //1. 통신을 해서 응답 받기
    //한 건이면 one, 여러건이면 list  -> 우리끼리 컨벤션
    //List<dynamic> list = await PostRepository().findAll();
    List<dynamic> list = await PostRepository.instance.findAll();

    //2. 파싱
    List<_Post> posts = list.map((e) => _Post.fromMap(e)).toList();

    //3. 상태 확인
    state = PostListModel(
        posts); //깊은 복사 (기존 데이터를 건드리지 않는다. posts를 생성자에 전달하면서 새로운 객체 생성)
  }
}

// 2. 창고 데이터 (State) -> 상태로 만드는 이유는 클래스기 때문
// 상태로 데이터를 유지
class PostListModel {
  //private으로 쓸려고 언더바를 붙여서 뺐다.
  List<_Post> posts;

  PostListModel(this.posts);
}

class _Post {
  int id;
  String title;

  //json을 map으로 받아서 우리가 일일이 값을 빼서 객체로 만드는 것이 아니라
  //요청해서 json을 받으면 map으로 받아서 만들어둔 _Post의 fromMap생성자에 전달해서 생성자에서 converting 해서 받아준다.
  _Post.fromMap(map)
      : this.id = map['id'],
        this.title = map['title'];
}

// 3. 창고 관리자 (Provider)
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
final postListProvider =
    StateNotifierProvider<PostListVM, PostListModel?>((ref) {
  //처음에 창고를 null로 전달하고 notifyInit() 함수를 호출하고 이 함수가 종료될 때 상태변화
  return PostListVM(null)..notifyInit();
});

class Book extends BookBase {
  @override
  String isbn13;
  @override
  String title;
  @override
  String author;
  @override
  String? description;
  @override
  String cover;

  int categoryId;
  bool? lendStatus;
  int? reservationCount;

  Book({
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

List<Book> BookList = [
  Book(
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
  Book(
      lendStatus: true,
      reservationCount: 2,
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
