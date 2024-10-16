import 'package:bookbox/ui/main/home/_components/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고
class CateTabVM extends StateNotifier<CateTabModel?> {
  CateTabVM(super.state);

  Future<void> notifyInit() async {
    // 1. 통신 해서 응답 받기
    var (cateList, bookList) =
        await HomeRepository().findCateTap(); // 변수 이름을 일관되게 설정
    // 2. 파싱
    List<Cate> cates = cateList.map((e) => Cate.fromMap(e)).toList();
    List<_Book> books = bookList.map((e) => _Book.fromMap(e)).toList();

    // 3. 상태 갱신
    state = CateTabModel(cates, books, false); // CateTabModel 생성자에 직접 전달
  }

  void openAndClosePanel() {
    CateTabModel cateTabModel = state!;
    cateTabModel.isOpen = !(cateTabModel.isOpen);
    state = CateTabModel.copy(cateTabModel);
  }

  Future<void> findCateTapFiler(String id) async {
    List<dynamic> list = await HomeRepository().findCateTapFiler(id);
    List<_Book> books = list.map((e) => _Book.fromMap(e)).toList();
    // 1.
    state = CateTabModel(state!.cates, books, false);
    // 2.
    //CateTabModel cateTabModel = state!;
    //cateTabModel.books = books;
    //state = CateTabModel.copy(cateTabModel);
  }
}

// 2. 창고 데이터
class CateTabModel {
  List<Cate> cates;
  List<_Book> books;
  bool isOpen;

  CateTabModel(this.cates, this.books, this.isOpen);

  CateTabModel.copy(CateTabModel cateModel)
      : this.cates = cateModel.cates,
        this.books = cateModel.books,
        this.isOpen = cateModel.isOpen;
}

// 3. 창고 관리자
final cateTabProvider = StateNotifierProvider<CateTabVM, CateTabModel?>((ref) {
  return CateTabVM(null)..notifyInit();
});

// Riverpod 상태를 관리할 프로바이더
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class Cate {
  String categoryId;
  String categoryName;

  Cate.fromMap(map)
      : this.categoryId = map["id"],
        this.categoryName = map["name"];
}

class _Book {
  String isbn13;
  String title;
  String author;
  String? description;
  String cover;

  _Book.fromMap(map)
      : this.isbn13 = map["isbn13"],
        this.title = map["title"],
        this.author = map["author"],
        this.description = map["description"],
        this.cover = map["cover"];
}
