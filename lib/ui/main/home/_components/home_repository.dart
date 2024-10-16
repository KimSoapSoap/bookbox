import 'package:bookbox/core/utils.dart';

class HomeRepository {
  // 최신업데이트
  Future<List<dynamic>> findUptodateTap() async {
    // 1. 통신 -> response [deader, body]
    var response = await dio.get("/api/main/uptodate-tap");
    // 2. body 부분 리턴
    List<dynamic> responseBook = response.data["body"];
    // list 의 map 타입
    return responseBook;
  }

  // 주제별
  Future<(List<dynamic>, List<dynamic>)> findCateTap() async {
    // 1. 통신 -> response [deader, body]
    var response = await dio.get("/api/main/cate-tap");
    // 2. body 부분 리턴
    List<dynamic> responseCate = response.data["body"]["cates"];
    List<dynamic> responseBook = response.data["body"]["books"];
    // list 의 map 타입
    return (responseCate, responseBook);
  }

  // 카테고리 필터
  Future<List<dynamic>> findCateTapFiler(String id) async {
    // 1. 통신 -> response [deader, body]
    var response = await dio.get("/api/main/sort?id=${id}");
    // 2. body 부분 리턴
    List<dynamic> responseBook = response.data["body"];
    // list 의 map 타입
    return responseBook;
  }
}
