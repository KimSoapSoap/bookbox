import 'package:bookbox/ui/_components/custom_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고
class DetailVm extends StateNotifier<DatailModel?> {
  DetailVm(super.state);
}

// 2. 창고 데이터
class DatailModel {
  List<_Review> reviews;
  _Book book;

  DatailModel(this.reviews, this.book);
}

// 3. 창고 관리자
final DatailProvider = StateNotifierProvider<DetailVm, DatailModel?>((ref) {
  return DetailVm(null);
});

class _Review {
  int reviewId;
  int userId;
  String username;
  String isbn13;
  String content;
  String createdAt;

  _Review.from(map)
      : this.reviewId = map["reviewId"],
        this.userId = map["userId"],
        this.username = map["username"],
        this.isbn13 = map["isbn13"],
        this.content = map["content"],
        this.createdAt = map["createdAt"];
}

class _Book {
  String isbn13;
  String title;
  String author;
  String? description;
  String cover;
  int categoryId;

  _Book.from(map)
      : this.isbn13 = map["isbn13"],
        this.title = map["title"],
        this.author = map["author"],
        this.description = map["description"],
        this.categoryId = map["categoryId"],
        this.cover = map["cover"];
}
