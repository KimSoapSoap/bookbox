import 'package:bookbox/data/repository/main/library/favorite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteTabVm extends StateNotifier<FavoriteModel?> {
  FavoriteTabVm(super.state);

  //처음에 대여중 리스트 불러오기
  Future<void> notifyInit() async {
    List<dynamic> list = await FavoriteRepository.instance.findAll();

    List<_Book> newList = list.map((e) => _Book.fromMap(e)).toList();

    state = FavoriteModel(newList);
  }

  //책 대여
  Future<void> lendBook(String isbn13) async {
    dynamic response = await FavoriteRepository.instance.lendBook(isbn13);
    print(response);
    // 리스트를 순회하면서 해당 도서를 찾아 lendStatus를 true로 업데이트
    List<_Book> updatedList = state!.list.map((book) {
      if (book.isbn13 == isbn13) {
        // 같은 isbn13을 가진 책의 lendStatus를 true로 변경
        return _Book(
          isbn13: book.isbn13,
          title: book.title,
          cover: book.cover,
          author: book.author,
          description: book.description,
          lendStatus: true,
          // 대여 상태로 변경
          reservationCount: book.reservationCount,
        );
      }
      return book; // 다른 책은 그대로 반환
    }).toList();

    // 상태를 업데이트하여 화면 갱신
    state = FavoriteModel(updatedList);
  }

  //책 예약
  Future<void> returnBook(String isbn13) async {
    //dynamic returnedDate = await FavoriteRepository.instance.returnBook(isbn13);

    List<_Book> updatedList =
        state!.list.where((book) => book.isbn13 != isbn13).toList();

    // 상태를 업데이트하여 화면을 다시 그리게 함
    state = FavoriteModel(updatedList);
  }
}

// 2. 창고 데이터 (State)
class FavoriteModel {
//private으로 쓸려고 언더바를 붙여서 뺐다.
  List<_Book> list;

  FavoriteModel(this.list);
}

class _Book {
  String isbn13;
  String title;
  String cover;
  String? author;
  String? description;
  bool? lendStatus;
  int? reservationCount;

  _Book({
    required this.isbn13,
    required this.title,
    required this.author,
    required this.description,
    required this.cover,
    required this.lendStatus,
    required this.reservationCount,
  });

  _Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.cover = map['cover'],
        this.author = map['author'],
        this.description = map['description'],
        this.lendStatus = map['lendStatus'],
        this.reservationCount = map['reservationCount'];
}

// 3. 창고 관리자 (Provider)
final favoriteProvider =
    StateNotifierProvider<FavoriteTabVm, FavoriteModel?>((ref) {
  return FavoriteTabVm(null)..notifyInit();
});
