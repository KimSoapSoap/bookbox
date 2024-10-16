import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';

class HistoryRepository {
  static HistoryRepository instance = HistoryRepository._single();

  HistoryRepository._single();

  Future<Map<String, dynamic>> autoLogin(String accessToken) async {
    final response = await dio.post(
      "/auto/login",
      options: Options(headers: {"Authorization": "Bearer $accessToken"}),
    );

    //정상이 아닌 것만 처리
    if (response.statusCode != 200) {}

    Map<String, dynamic> body = response.data;
    //세션 정보 동기화 해주려고 리턴 해준다.
    return body;
  }

  //2개를 리턴하는 구조분해 리턴
  Future<(Map<String, dynamic>, String)> login(
      String username, String password) async {
    final response = await dio
        .post("/login", data: {"username": username, "password": password});

    String accessToken = response.headers["Authorization"]![0];

    Map<String, dynamic> body = response.data;
    //세션 정보 동기화 해주려고 리턴 해준다.
    return (body, accessToken);
  }
}
