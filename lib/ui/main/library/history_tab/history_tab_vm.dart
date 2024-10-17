import 'package:bookbox/core/utils/date_format.dart';
import 'package:bookbox/data/repository/main/library/history_repository.dart';
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

//요청하면 책이랑 조인해서 DTO로 한 덩어리로 올 테니까 여기에 책 정보도 일단 넣어둬야 하나?
//바디에 lend랑 book이랑 별개로 있으면 각자 객체 생성해서 사용할텐데 어찌될지 모르니까 일단
//각각으로 해서
class Lend {
  int? lendId;
  String? lendDate;
  String? returnDate;
  bool? returnStatus;

  String isbn13;
  String title;
  String cover;

  Lend({
    required this.lendId,
    required this.lendDate,
    required this.returnDate,
    required this.returnStatus,
    required this.isbn13,
    required this.title,
    required this.cover,
  });

  Lend.fromMap(map)
      : this.lendId = map['lendId'],
        this.lendDate = DateUtil.format(map['lendDate']),
        this.returnStatus = map['returnStatus'],
        this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.cover = map['cover'],
        this.returnDate = DateUtil.format(map['returnDate']);
}
