import 'package:bookbox/data/repository/main/library/lend_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LendTabVm extends StateNotifier<LendListModel?> {
  LendTabVm(super.state);

  Future<void> notifyInit() async {
    print("여기는");
    List<dynamic> list = await LendRepository.instance.findAll();

    List<_Book> newList = list.map((e) => _Book.fromMap(e)).toList();

    state = LendListModel(newList);
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

  _Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.cover = map['cover'];
}

// 3. 창고 관리자 (Provider)
final LendListProvider =
    StateNotifierProvider<LendTabVm, LendListModel?>((ref) {
  return LendTabVm(null)..notifyInit();
});
