import 'package:bookbox/data/post_repository.dart';
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
