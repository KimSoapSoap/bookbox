import 'package:bookbox/ui/detail/detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ReviewVm extends StateNotifier<ReviewModel?> {
  ReviewVm(super.state);

  Future<void> notifyInit(String isbn13) async {
    await _fetchComments(isbn13);
  }

  Future<void> notifySave(String isbn13, String contnent) async {
    // 통신코드
    Map<String, dynamic> one =
        await DetailRepository().save(isbn13, contnent); // 한 건 받음
    Logger().d("댓글 달림? , ${one}");

    await _fetchComments(isbn13);
  }

  Future<void> notifyDelete(int id, String isbn13) async {
    await DetailRepository().delete(id);

    // 상태 업데이트
    await _fetchComments(isbn13);
  }

  Future<void> _fetchComments(String isbn13) async {
    List<dynamic> list = await DetailRepository().findDetailPageComment(isbn13);
    List<Review> reviews = list.map((e) => Review.fromMap(e)).toList();

    // 상태 업데이트
    state = ReviewModel(reviews);
  }
}

// 2. 창고 데이터 (Model)
class ReviewModel {
  List<Review> reviews;

  ReviewModel(this.reviews);

  ReviewModel.copy(ReviewModel reviewModel)
      : this.reviews = reviewModel.reviews;
}

// 3. 창고 관리자 (Provider)
final ReviewProvider =
    StateNotifierProvider.family<ReviewVm, ReviewModel?, String>((ref, isbn13) {
  final detailVm = ReviewVm(null);
  detailVm.notifyInit(isbn13); // isbn13을 사용하여 초기화
  return detailVm;
});

// Review 클래스
class Review {
  int id;
  String content;
  String createdAt;
  String nick;
  bool owner;

  Review.fromMap(map)
      : this.id = map["id"],
        this.content = map["content"],
        this.createdAt = map["createdAt"],
        this.nick = map["nick"],
        this.owner = map["owner"];
}
