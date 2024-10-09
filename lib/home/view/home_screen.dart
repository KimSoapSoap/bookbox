import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //root_tab 보면 홈, 서재, 검색, 설정으로 이동시키는데 여기서 다시 appBar의 bottom에 탭바 달아주려니까
    //너무 짬뽕이 돼서 각자 페이지로 이동해서 탭바를 달아줬습니다(홈, 서재)

    //바텀 네비게이션을 만든 root_tab에서 default_layout을 사용해서 Sccafold를 이미 써서
    //홈, 서재, 검색, 설정은 이미 Sccafold 내부에 있어서 바로 Column을 사용했고
    //appBar의 bottom이 아닌 Column에서 탭바를 사용했습니다.

    //마찬가지로 tabBar의 내부에 있는 애들도 이미 Sccafold 내부에 있어서
    //바텀 네이게이션바 + 탭바의 내부에 있는 녀석들 제외하고 새로운 화면은
    //Sccafold를 사용할 때 DefaultLayout() 사용하시면 됩니다

    //이때 appBar에 customAppBar()를 전달해도 되고
    //titleText라는 이름으로 text를 전달하면 해당 이름으로 appBar 타이틀 가운데 출력 됩니다.

    return Column(
      children: [
        TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          controller: tabController,
          tabs: [
            Tab(text: '추천'),
            Tab(text: '최신 업데이트'),
            Tab(text: '인기'),
            Tab(text: '주제별'),
          ],
        ),
        // Expanded로 TabBarView를 감싸서 화면 전환 지원
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              Center(child: Text('홈 탭 1 내용')),
              Center(child: Text('홈 탭 2 내용')),
              Center(child: Text('홈 탭 3 내용')),
              Center(child: Text('홈 탭 4 내용')),
            ],
          ),
        ),
      ],
    );
  }
}
