import 'package:bookbox/core/utils/date_format.dart';
import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LendRepository {
  static LendRepository instance = LendRepository._single();

  LendRepository._single();

  //대여중 리스트 출력
  Future<List<dynamic>> findAll() async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    //토큰 저장해둔 걸 불러 온다.
    // 1. 통신
    Logger().d("통신 고고고");
    var response = await dio.get("/api/lends/list",
        options: Options(headers: {"Authorization": accessToken}));

    // 2. body 부분 리턴
    dynamic responseBody = response.data['body'];
    List<dynamic> list = responseBody['books'];
    return list;
  }

//연장하기
  Future<String> extendBook(String isbn13) async {
    String? accessToken = await secureStorage.read(key: "accessToken");

    var response = await dio.put("/api/lends/extension",
        data: {"isbn13": isbn13},
        options: Options(headers: {"Authorization": accessToken}));

    dynamic responseBody = response.data['body'];
    print(responseBody);
    dynamic returnDate = responseBody['returnDate'];
    print(returnDate);

    return DateUtil.format(returnDate);
  }

//반납하기
  Future<String> returnBook(String isbn13) async {
    String? accessToken = await secureStorage.read(key: "accessToken");

    var response = await dio.put("/api/lends/return",
        data: {"isbn13": isbn13},
        options: Options(headers: {"Authorization": accessToken}));

    dynamic responseBody = response.data['body'];
    print(responseBody);
    dynamic returnedDate = responseBody['returnDate'];
    print(returnedDate);

    return DateUtil.format(returnedDate);
  }

//상세 보기
}
