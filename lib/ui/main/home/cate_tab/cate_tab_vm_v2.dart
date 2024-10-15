import 'package:bookbox/ui/_components/custom_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CateTabModel {
  List<_Cate> cates;
  List<_Book> books;

  CateTabModel(this.cates, this.books);
}

class CateTabVM extends StateNotifier<CateTabModel?> {
  CateTabVM(super.state);
}

final cateTabProvider = StateNotifierProvider<CateTabVM, CateTabModel?>((ref) {
  return CateTabVM(null);
});

class _Cate {
  int categoryId;
  String categoryName;

  _Cate({
    required this.categoryId,
    required this.categoryName,
  });
}

class _Book extends BookBase {
  @override
  String isbn13;
  @override
  String title;
  @override
  String author;
  @override
  String? description;
  @override
  String cover;
  int categoryId;

  _Book({
    required this.isbn13,
    required this.title,
    required this.author,
    required this.description,
    required this.categoryId,
    required this.cover,
  });
}
