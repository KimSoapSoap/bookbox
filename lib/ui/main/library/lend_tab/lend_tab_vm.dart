import 'package:bookbox/core/utils/date_format.dart';
import 'package:bookbox/data/repository/main/library/lend_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LendTabVm extends StateNotifier<LendListModel?> {
  LendTabVm(super.state);

  //처음에 대여중 리스트 불러오기
  Future<void> notifyInit() async {
    List<dynamic> list = await LendRepository.instance.findAll();

    List<_Book> newList = list.map((e) => _Book.fromMap(e)).toList();

    state = LendListModel(newList);
  }

  //책 연장
  Future<void> extendBook(String isbn13) async {
    dynamic newReturnDate = await LendRepository.instance.extendBook(isbn13);

    print('연장 날짜 $newReturnDate');

    // 리스트를 순회하면서 해당 도서를 찾아 연장 날짜를 업데이트 (map 사용)
    List<_Book> updatedList = state!.list.map((book) {
      if (book.isbn13 == isbn13) {
        // 연장된 날짜로 해당 도서의 정보 업데이트
        return _Book(
          isbn13: book.isbn13,
          title: book.title,
          cover: book.cover,
          returnDate: newReturnDate, // 연장된 날짜만 수정
        );
      }
      return book; // 다른 도서는 그대로 유지
    }).toList();

    // 상태를 새로운 리스트로 업데이트하여 화면 갱신
    state = LendListModel(updatedList);
  }

  //책 반납
  Future<void> returnBook(String isbn13) async {
    dynamic returnedDate = await LendRepository.instance.returnBook(isbn13);

    List<_Book> updatedList =
        state!.list.where((book) => book.isbn13 != isbn13).toList();

    // 상태를 업데이트하여 화면을 다시 그리게 함
    state = LendListModel(updatedList);
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
  String returnDate;

  _Book(
      {required this.returnDate,
      required this.isbn13,
      required this.cover,
      required this.title});

  //String returnDate;

  _Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.cover = map['cover'],
        this.returnDate = DateUtil.format(map['returnDate']);

//this.returnDate = map['returnDate'];
}

// 3. 창고 관리자 (Provider)
final LendListProvider =
    StateNotifierProvider<LendTabVm, LendListModel?>((ref) {
  return LendTabVm(null)..notifyInit();
});
