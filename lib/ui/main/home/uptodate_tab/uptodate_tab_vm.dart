import 'package:bookbox/ui/main/home/_components/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UptodateTabVm extends StateNotifier<UptodateTabModel?> {
  UptodateTabVm(super.state);

  Future<void> notifyInit() async {
    // 1. 통신을 통해 응답 받기
    List<dynamic> list = await HomeRepository().findUptodateTap();
    // 2. 파싱
    List<_Book> books = list.map((e) => _Book.fromMap(e)).toList();
    // 3. 상태 갱신
    state = UptodateTabModel(books);
  }
}

// 2. 창고 데이터
class UptodateTabModel {
  List<_Book> books;

  UptodateTabModel(this.books);
}

// 3. 관리자
final UptodateTabProvider =
    StateNotifierProvider<UptodateTabVm, UptodateTabModel?>((ref) {
  return UptodateTabVm(null)..notifyInit();
});

class _Book {
  String isbn13;
  String title;
  String author;
  String description;
  String cover;

  _Book.fromMap(map)
      : this.isbn13 = map["isbn13"],
        this.title = map["title"],
        this.author = map["author"],
        this.description = map["description"],
        this.cover = map["cover"];
}
