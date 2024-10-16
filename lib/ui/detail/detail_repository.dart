import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DetailRepository {
  Future<Map<String, dynamic>> findDetailPage(String isbn13) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    Logger().d("accessToken? , ${accessToken}");

    // 1. 통신 -> response [deader, body]
    var response = await dio.get("/api/books/detail-onlybook?isbn13=${isbn13}",
        options: Options(headers: {"Authorization": "Bearer ${accessToken}"}));
    // 2. body 부분 리턴
    Map<String, dynamic> responseBook = response.data["body"];
    Logger().d("body, ${responseBook}");
    // list 의 map 타입
    return responseBook;
  }

  Future<List<dynamic>> findDetailPageComment(String isbn13) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    Logger().d("accessToken? , ${accessToken}");

    // 1. 통신 -> response [deader, body]
    var response = await dio.get(
        "/api/books/detail-onlybookcomment?isbn13=${isbn13}",
        options: Options(headers: {"Authorization": "Bearer ${accessToken}"}));
    // 2. body 부분 리턴
    List<dynamic> responseBook = response.data["body"];
    // list 의 map 타입
    return responseBook;
  }

  Future<Map<String, dynamic>> save(String isbn13, String content) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    Logger().d("accessToken? , ${accessToken}");

    Response response = await dio.post("/api/books/review",
        data: {"isbn13": isbn13, "content": content},
        options: Options(headers: {"Authorization": "Bearer ${accessToken}"}));

    Map<String, dynamic> responseBody = response.data["body"];
    Logger().d(responseBody);

    // list 의 map 타입
    return responseBody;
  }

  Future<void> delete(int id) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    var response = await dio.delete("/api/books/review/$id",
        options: Options(headers: {"Authorization": "Bearer ${accessToken}"}));

    Logger().d(response);
  }
}
