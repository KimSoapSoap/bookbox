import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HistoryRepository {
  static HistoryRepository instance = HistoryRepository._single();

  HistoryRepository._single();

  //대여기록 출력
  Future<List<dynamic>> findAll() async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    //토큰 저장해둔 걸 불러 온다.
    // 1. 통신
    Logger().d("통신 고고고");
    var response = await dio.get("/api/lends/list/history",
        options: Options(headers: {"Authorization": accessToken}));

    print(response);
    // 2. body 부분 리턴
    List<dynamic> list = response.data['body'];
    return list;
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
