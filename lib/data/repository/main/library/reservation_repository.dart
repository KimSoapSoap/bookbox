import 'package:bookbox/core/utils/my_http.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ReservationRepository {
  static ReservationRepository instance = ReservationRepository._single();

  ReservationRepository._single();

  //예약중인 책 리스트 출력
  Future<List<dynamic>> findAll() async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    //토큰 저장해둔 걸 불러 온다.
    // 1. 통신
    Logger().d("통신 고고고");
    var response = await dio.get("/api/reservation-list",
        options: Options(headers: {"Authorization": accessToken}));

    print(response);
    // 2. body 부분 리턴
    List<dynamic> list = response.data;
    print(list);
    return list;
  }

  //예약 취소
  //대여중 리스트 출력
  Future<String> cancelReservation(String isbn13) async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    //토큰 저장해둔 걸 불러 온다.
    // 1. 통신
    Logger().d("통신 고고고");
    var response = await dio.put("/api/reservation-cncl/${isbn13}",
        options: Options(headers: {"Authorization": accessToken}));

    // 2. body 부분 리턴
    dynamic responseBody = response.data['body'];
    print(responseBody);
    return responseBody;
  }
}
