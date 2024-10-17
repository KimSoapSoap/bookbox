import 'package:bookbox/core/utils/my_http.dart';
import 'package:logger/logger.dart';

class SearchRepository {
  static SearchRepository instance = SearchRepository._single();

  SearchRepository._single();

  //예약중인 책 리스트 출력
  Future<List<dynamic>> findAllByKeyword(String keyword) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    //토큰 저장해둔 걸 불러 온다.
    // 1. 통신
    Logger().d("검색 고고고");
    var response = await dio.get("/api/searches?keyword=${keyword}");

    print(response);
    // 2. body 부분 리턴
    List<dynamic> list = response.data['body'];
    print(list);
    return list;
  }
}
