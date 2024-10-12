import 'package:flutter/material.dart';

// 이런식으로 기본 레이아웃을 만들어 주는데 기본적으로 존재해야될 body 부분을 child로 필수로 받는 것 외에는
// 안 들어올 수도 있으므로(앱바나 바텀네비게이션 바가 없는 화면도 있으니) null 가능하게 해서 null처리 해준다.
// appBar는 그냥 text만 받아섯 제목이 들어오면 타이틀만 뿌려주는 메서드를 만들어놨고
// bottomNavigationBar는 그냥 만들어서 들어오면 그걸 뿌려주고 없으면 없는 걸로 만들었다.

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final String? titleText;
  final TabBar? tabBar;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.titleText,
    this.tabBar,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  //전달 받는 AppBar가 없으면 뒤로가기 버튼과 title에 Text만 있는 앱바 추가 후
  //전달 받은 titleText가 있으면 이를 Text로 없으면 기본 BookBox 혹은 빈 문자열(의논 필요)로 출력
  PreferredSizeWidget? renderAppBar() {
    //appBar없을 때 titleText만 넣으면 해당 글자로 아이콘과 글자가 중앙에 위치하는 앱바 생성됨
    if (appBar == null) {
      return AppBar(
        backgroundColor: Colors.white,
        //앞으로 튀어나온 듯한 설정. 요즘은 그 효과를 없애는 0이 트렌드
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/logo.png",
            //   width: 30,
            //   height: 30,
            // ),
            SizedBox(
              width: 10,
            ),
            Text(
              titleText ?? 'BookBox',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        //MaterialApp()은 AppBar의 title 정렬이 기본 왼쪽에서 시작하므로 가운데 정렬 필요시 옵션 주기
        centerTitle: true,
        foregroundColor: Colors.black,
      );
    } else {
      return appBar;
    }
  }
}
