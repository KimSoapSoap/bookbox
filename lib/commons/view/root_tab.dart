import 'package:bookbox/commons/component/custom_app_bar.dart';
import 'package:bookbox/commons/layout/default_layout.dart';
import 'package:bookbox/home/view/home_screen.dart';
import 'package:bookbox/library/view/library_screen.dart';
import 'package:bookbox/search/view/search_screen.dart';
import 'package:bookbox/setting/view/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  // ?로 null처리를 해서 작업을 해도 되지만 사실상 initState()에서 controller가 무조건 선언되는 것을 알기 때문에 late를 붙이는 것이 낫다.
  // ?로 null처리를 하면 컨트롤러를 쓸 때마다 null처리를 해아 한다. if(controller == null ) { } 이런 식으로..
  // 그래서 그냥 late 키워드만 붙여놓으면 처음에 안 들어올 땐 값을 사용할 수 없고 initState()에서 초기화 되면 사용할 수 있게 한다.
  late TabController controller;
  int index = 0;

  // 각 탭의 제목 리스트
  final List<String> titles = ['홈', '내서재', '검색', '설정'];

  @override
  void initState() {
    super.initState();
    //length는 TabBarView의 children에 넣은 개수
    //vsync에는 렌더링 엔진에서 필요한 건데 이거는 컨트롤러를 선언하는 현재 state를 넣어준다. 또는 stateful Widget을 넣어준다.
    //즉, this를 넣어주면 된다. 그런데 이 this가 특정 기능을 가지고 있어야 한다.
    // Single Ticker Provide State Mixin이라는 것을 가지고 있어야 한다. 현재 Widget에다가 이 mixin을 추가해준다(with로 추가)
    // _RootTabState 뒤에 with Single Ticker Provide State Mixin 해주면 됨
    // 앞으로 vsync를 보면 이렇게 해주면 된다. 애니메이션과 관련된 컨트롤러들은 이렇게 세팅 해줘야 하는 경우가 많다.
    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  // dispose()는 Flutter에서 State 객체가 위젯 트리에서 제거되어 더 이상 필요하지 않을 때 호출된다.
  // 주로 initState()에서 설정한 애니메이션 컨트롤러나 스트림, 리스너 같은 리소스를 해제할 때 사용됨.
  // 즉, dispose()는 이러한 리소스들을 정리하여 메모리 누수를 방지하고, 더 이상 필요하지 않은 작업들을 중단해준다.
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      // OnTab에서  controller.animateTo(index); 코드로 버튼 누를 때 index를 controller에 전달하고
      // 그 전달된 index를 view 전환할 때 animateTo를 이용해서 애니메이션으로 전환
      // 그래서 controller는 이미 클릭된 바텀 네이게이션 바의 index 번호를 가지고 있는 것. 이를 변수에 넣어주는 것이다.
      // 그걸 setSate(( ) { }) 내부에 넣었으니 바텀 네비게이션 바에 선택된 버튼도 상태 변화가 일어나는 것
      // 이를 controller의 addListener에 전달 해준다.
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      // AppBar의 title을 현재 선택된 탭의 제목으로 설정
      appBar: CustomAppBar(
        titleText: titles[index],
      ),
      //titleText: titles[index],
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          HomeScreen(),
          LibraryScreen(),
          SearchScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        //현재 선택된 index 지정
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(CupertinoIcons.house),
          ),
          BottomNavigationBarItem(
            label: '내서재',
            icon: Icon(CupertinoIcons.book),
          ),
          BottomNavigationBarItem(
            label: '검색',
            icon: Icon(CupertinoIcons.search),
          ),
          BottomNavigationBarItem(
            label: '설정',
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
      ),
    );
  }
}
