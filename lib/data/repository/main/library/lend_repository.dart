import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LendRepository {
  static LendRepository instance = LendRepository._single();

  LendRepository._single();

  Future<List<dynamic>> findAll() async {
    // 1. 통신
    Logger().d("통신 고고고");
    var response = await dio.get("/api/lends/list",
        //로그인 문제로 임시로 토큰 넣음
        options: Options(headers: {
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdXRoIiwicm9sZSI6IlVTRVIiLCJpZCI6MSwiZXhwIjoxNzI5MDMwNTMxfQ.Tzq98IX12CfE6vFi5NV63fUnDA3Kf4XvONgZ17i1rxSjutcyk-533DxGoOYVgfpaCoXYG2ZFh2YNW1-z87SMKA"
        }));

    // 2. body 부분 리턴
    dynamic responseBody = response.data['body'];
    print(responseBody);
    List<dynamic> list = responseBody['books'];
    // List<dynamic> list = jsonData['body']['books'];

    return list;
  }

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
