import 'package:bookbox/core/utils/my_http.dart';
import 'package:bookbox/data/repository/user/user_repository.dart';
import 'package:bookbox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

//글로벌 모델. 글로벌 데이터 덩어리를 관리
//창고겸 데이터.
class SessionGM {
  int? id;
  String? username;
  String? accessToken;
  bool isLogin; // 초기값 false 넣어주고 null 처리 하지 않는다. 무조건 들어오므로. 나중에 !안 쓰기 위해서

  SessionGM({this.id, this.username, this.accessToken, this.isLogin = false});

  final mContext = navigatorKey.currentContext!;

  Future<void> login(String username, String password) async {
    // 1. 통신 {success: 머시기, status: 미시기, errorMessage:머시기, response: 오브젝트}
    //리턴을 2개 했기 때문에 첫 번째에
    Logger().d("통신 시도");
    var (body, accessToken) =
        await UserRepository.instance.login(username, password);

    //통신 잘 되나 확인하기
    Logger().d("세션 창고의 login()메서드 실행됨 ${body}, ${accessToken}");

    // 2. 성공 or 실패 처리
    if (body["status"] == 200) {
      Logger().d("로그인 성공");
      // 성공 처리
      // (1) SessionGM값 변경
      this.id = body["id"];
      this.username = body["username"];
      this.accessToken = accessToken;
      this.isLogin = true;

      // (2) 휴대폰 하드 저장
      // 반드시 저장 하고 넘어가기 위해 await 붙임
      // sharedStorage가 있고 securedStorage가 있는데 토큰은 securedStorage에 저장
      await secureStorage.write(key: "accessToken", value: accessToken);

      Logger().d("토큰 저장");
      // (3) dio에 토큰 세팅 -> 매번 토큰 안 꺼내기 위해
      dio.options.headers["Authorization"] =
          accessToken; // Bearer 떼고 받았기 때문에 그냥 보내준다.

      // (4) 화면 이동
      Logger().d("화면 이동 드가자");
      Navigator.popAndPushNamed(mContext, "/home");
    } else {
      Logger().d("로그인 실패");
      ScaffoldMessenger.of(mContext)
          .showSnackBar(SnackBar(content: Text('$body["msg"]')));
    }
  }

  Future<void> join() async {}

  Future<void> logout() async {
    // 1. 토큰 삭제
    // accessToken을 메모리, 하드디스크에서 삭제시키는 것이므로 await를 걸어준다.
    // OS에서 하드웨어 레벨까지 내려갔다가 오는 것이므로 시간이 좀 걸린다.
    // 즉 I/O가 발생하는 것은 다 await를 붙여주면 된다.
    await secureStorage.delete(key: "accessToken");

    // 2. 토큰 삭제했으므로 상태를 바꿔주면 된다
    // 내 메모리에서 처리하는 것이므로 await가 필요 없다.
    this.id = null;
    this.username = null;
    this.accessToken = null;
    this.isLogin = false;
    //로그아웃했으므로 로그인 페이지로 보내면서 다 지우고
    Logger().d(
        '로그아웃 실행 => id: $id,  username: $username,  accessToken: $accessToken, isLogin: $isLogin');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.popAndPushNamed(mContext, "/login");
    });
  }

  Future<void> autoLogin() async {
    // 1. secureStorage에서 accessToken 꺼내기. 없으면 /login으로 보내기
    String? accessToken = await secureStorage.read(key: "accessToken");

    if (accessToken == null) {
      Logger().d("토큰이 없습니다.");

      Navigator.pushReplacementNamed(mContext, "/login");
    } else {
      // 2. api 호출
      Map<String, dynamic> body =
          await UserRepository.instance.autoLogin(accessToken);

      Logger().d("세션 창고의 autoLogin()메서드 실행됨 ${body}, ${accessToken}");
      // 3. 정상이면 post/list
      // splash창을 날리고 가야되므로 popAndPush로 보낸다.
      // 안 날리면 계속 스플래쉬 화면이 뒤에 남아 있으므로
      this.id = body["id"];
      this.username = body["username"];
      this.accessToken = accessToken;
      this.isLogin = true;

      Logger().d('화면이동시 필요한 context: $mContext');
      // 4. 정상이면 /home이동 만료됐으면 로그인으로 (pop and pushNamed)

      //토큰 만료시
      if (body["status"] == 401) {
        Logger().d("토큰 만료");
        Navigator.pushReplacementNamed(mContext, "/login");

        //토큰 유효
      } else {
        Logger().d("토큰 유효");
        Navigator.pushReplacementNamed(mContext, "/home");
      }
    }
  }
}

final sessionProvider = StateProvider<SessionGM>((ref) {
  return SessionGM();
});
