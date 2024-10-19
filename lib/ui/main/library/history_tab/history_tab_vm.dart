import 'package:bookbox/data/repository/main/library/history_repository.dart';
import 'package:bookbox/ui/main/library/_components/library_lend.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryTabVm extends StateNotifier<HistoryModel?> {
  HistoryTabVm(super.state);

  //처음에 대여중 리스트 불러오기
  Future<void> notifyInit() async {
    List<dynamic> list = await HistoryRepository.instance.findAll();

    List<Lend> newList = list.map((e) => Lend.fromMap(e)).toList();

    state = HistoryModel(newList);
  }
}

// 2. 창고 데이터 (State)
class HistoryModel {
//private으로 쓸려고 언더바를 붙여서 뺐다.
  List<Lend> list;

  HistoryModel(this.list);
}

// 3. 창고 관리자 (Provider)
final historyProvider =
    StateNotifierProvider<HistoryTabVm, HistoryModel?>((ref) {
  return HistoryTabVm(null)..notifyInit();
});
