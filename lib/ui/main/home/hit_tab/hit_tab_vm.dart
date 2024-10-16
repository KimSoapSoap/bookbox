import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고
class HitTabVM extends StateNotifier<HitTabModel?> {
  HitTabVM(super.state);

  Future<void> notifyInit() async {
    // 1. 통신을 통해 응답 받기
    // 2. 상태 갱신
  }
}

// 2. 창고데이터
class HitTabModel {
  List<_Book> books;

  HitTabModel(this.books);
}

// 3. 관리자
final HitTabProvider = StateNotifierProvider<HitTabVM, HitTabModel?>((ref) {
  return HitTabVM(null);
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
