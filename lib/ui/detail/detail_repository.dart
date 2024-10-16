import 'package:bookbox/core/utils.dart';
import 'package:dio/dio.dart';

class Token {
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdXRoIiwicm9sZSI6IlVTRVIiLCJpZCI6MiwiZXhwIjoxNzI5MDYyMzk5fQ.waQlrIqjogLpm4sX2FH3fqzM_3y8y9JUF8nr365-mL8rWk09Dw-kGgK7q06xFgb-2G7BBQeVqmUx2hCI10A61Q';
}

class DetailRepository {
  Token tokenInstance = Token();

  Future<Map<String, dynamic>> findDetailPageWithComment(String isbn13) async {
    // 1. 통신 -> response [deader, body]
    var response = await dio.post("/api/books/detail?isbn13=${isbn13}",
        options: Options(
            headers: {"Authrization": "Bearer ${tokenInstance.token}"}));
    // 2. body 부분 리턴
    Map<String, dynamic> responseBook = response.data["body"];
    // list 의 map 타입
    return responseBook;
  }
}
