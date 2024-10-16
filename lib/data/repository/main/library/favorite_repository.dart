import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';

class FavoriteRepository {
  static FavoriteRepository instance = FavoriteRepository._single();

  FavoriteRepository._single();

  //즐겨찾기 리스트 출력
  Future<List<dynamic>> findAll() async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    //토큰 저장해둔 걸 불러 온다.
    // 1. 통신
    var response = await dio.get("/api/likes",
        options: Options(headers: {"Authorization": accessToken}));

    // 2. body 부분 리턴
    dynamic responseBody = response.data['body'];
    List<dynamic> list = responseBody['likes'];
    return list;
  }

//대여하기
  Future<String> lendBook(String isbn13) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    var response = await dio.post("/api/lends}",
        data: {"isbn13": isbn13},
        options: Options(headers: {"Authorization": accessToken}));

    dynamic responseBody = response.data['body'];
    print(responseBody);

    return responseBody["bookTitle"];
  }
}
