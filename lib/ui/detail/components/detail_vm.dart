import 'package:bookbox/ui/detail/detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 (ViewModel)
class DetailVm extends StateNotifier<DetailModel?> {
  DetailVm(super.state);

  Future<void> notifyInit(String isbn13) async {
    Logger().d("들어왔니, ${isbn13}");
    // 1. 통신 해서 응답 받기
    Map<String, dynamic> one = await DetailRepository().findDetailPage(isbn13);
    Logger().d(one);
    // 2. 파싱
    DetailBookInfo book = DetailBookInfo.fromMap(one);
    Logger().d("흠... ${book}");
    // 3. 상태 갱신
    state = DetailModel(book);
  }
}

// 2. 창고 데이터 (Model)
class DetailModel {
  DetailBookInfo book;

  DetailModel(this.book);

  DetailModel.copy(DetailModel detailModel) : this.book = detailModel.book;
}

// 3. 창고 관리자 (Provider)
final detailProvider =
    StateNotifierProvider.family<DetailVm, DetailModel?, String>((ref, isbn13) {
  final detailVm = DetailVm(null);
  detailVm.notifyInit(isbn13); // isbn13을 사용하여 초기화
  return detailVm;
});

// DetailBookInfo 클래스
class DetailBookInfo {
  String isbn13;
  String title;
  String author;
  String cover;
  String publisher;
  String pubDate;
  String? description;
  bool lendStatus;
  bool reservationStatus;
  String categoryId;

  DetailBookInfo.fromMap(map)
      : this.isbn13 = map["isbn13"],
        this.title = map["title"],
        this.author = map["author"],
        this.cover = map["cover"],
        this.publisher = map["publisher"],
        this.pubDate = map["pubDate"],
        this.description = map["description"],
        this.lendStatus = map["lendStatus"],
        this.reservationStatus = map["reservationStatus"],
        this.categoryId = map["categoryId"];
}
