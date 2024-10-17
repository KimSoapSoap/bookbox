import 'package:bookbox/data/repository/main/library/reservation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReserveTabVm extends StateNotifier<ReservationListModel?> {
  ReserveTabVm(super.state);

  //예약중 리스트 불러오기
  Future<void> notifyInit() async {
    print("여기는");
    List<dynamic> list = await ReservationRepository.instance.findAll();

    List<_Book> newList = list.map((e) => _Book.fromMap(e)).toList();

    print(newList);
    state = ReservationListModel(newList);
  }

  //예약 취소
  Future<void> cancelReservation(String isbn13) async {
    dynamic returnDate =
        await ReservationRepository.instance.cancelReservation(isbn13);
    print('반납 날짜 $returnDate');

    //취소후 상태에서 값을 가져와서 where로 취소했던 놈 필터 하고 새로운 리스트 생성
    if (state != null) {
      List<_Book> updatedList =
          state!.list.where((book) => book.isbn13 != isbn13).toList();
      state = ReservationListModel(updatedList);
    }

    // 상태를 업데이트하여 화면을 다시 그리게 함
  }
}

// 2. 창고 데이터 (State)
class ReservationListModel {
//private으로 쓸려고 언더바를 붙여서 뺐다.
  List<_Book> list;

  ReservationListModel(this.list);
}

class _Book {
  String isbn13;
  String bookTitle;
  int sequence;
  String cover;

  _Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.sequence = map['sequence'],
        this.bookTitle = map['bookTitle'],
        this.cover = map['cover'];
}

// 3. 창고 관리자 (Provider)
final ReservationListProvider =
    StateNotifierProvider<ReserveTabVm, ReservationListModel?>((ref) {
  return ReserveTabVm(null)..notifyInit();
});
