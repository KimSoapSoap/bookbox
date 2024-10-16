import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendTabVm extends StateNotifier<RecommendTabModel?> {
  RecommendTabVm(super.state);

  Future<void> notifyInit() async {
    // 1. 통신을 통해 응답 받기
    // 2. 상태 갱신
  }
}

// 2. 창고 데이터
class RecommendTabModel {
  List<_Book> books;

  RecommendTabModel(this.books);
}

// 3. 관리자
final RecommendTabProvider =
    StateNotifierProvider<RecommendTabVm, RecommendTabModel?>((ref) {
  return RecommendTabVm(null);
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
