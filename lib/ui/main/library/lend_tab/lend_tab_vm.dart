import 'package:bookbox/data/repository/main/library/lend_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LendTabVm extends StateNotifier<LendListModel?> {
  LendTabVm(super.state);

  //처음에 대여중 리스트 불러오기
  Future<void> notifyInit() async {
    print("여기는");
    List<dynamic> list = await LendRepository.instance.findAll();

    List<_Book> newList = list.map((e) => _Book.fromMap(e)).toList();

    state = LendListModel(newList);
  }

  //책 연장
  Future<void> extendBook(String isbn13) async {
    dynamic returnDate = await LendRepository.instance.extendBook(isbn13);
    print('반납 날짜 $returnDate');
  }

  //책 반납
  Future<void> returnBook(String isbn13) async {
    dynamic returnedDate = await LendRepository.instance.returnBook(isbn13);
  }
}

// 2. 창고 데이터 (State)
class LendListModel {
//private으로 쓸려고 언더바를 붙여서 뺐다.
  List<_Book> list;

  LendListModel(this.list);
}

class _Book {
  String isbn13;
  String title;
  String cover;

  //String returnDate;

  _Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.cover = map['cover'];
//this.returnDate = map['returnDate'];
}

// 3. 창고 관리자 (Provider)
final LendListProvider =
    StateNotifierProvider<LendTabVm, LendListModel?>((ref) {
  return LendTabVm(null)..notifyInit();
});
