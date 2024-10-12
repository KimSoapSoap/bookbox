import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/main/home/home_page.dart';
import 'package:bookbox/ui/main/library/library_page.dart';
import 'package:bookbox/ui/main/search/search_page.dart';
import 'package:bookbox/ui/main/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int _currentTab = 0;
  var loadPages = [0];

  // 각 탭의 제목 리스트
  final List<String> titles = ['홈', '내서재', '검색', '설정'];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // AppBar의 title을 현재 선택된 탭의 제목으로 설정
        appBar: CustomAppBar(
          titleText: titles[_currentTab],
        ),
        //titleText: titles[index],
        body: IndexedStack(
          index: _currentTab,
          children: [
            loadPages.contains(0) ? const HomePage() : Container(),
            loadPages.contains(1) ? const LibraryPage() : Container(),
            loadPages.contains(2) ? const SearchPage() : Container(),
            loadPages.contains(3) ? const SettingPage() : Container(),
          ],
        ),
        bottomNavigationBar: _bottomNavigation());
  }

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black38,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      type: BottomNavigationBarType.fixed,

      currentIndex: _currentTab,
      onTap: (index) {
        var pages = loadPages;
        if (!pages.contains(index)) {
          pages.add(index);
          print(pages);
        }
        _currentTab = index;
        loadPages = pages;
        setState(() {});
      },
      //현재 선택된 index 지정
      items: [
        const BottomNavigationBarItem(
          label: '홈',
          icon: Icon(CupertinoIcons.house),
        ),
        const BottomNavigationBarItem(
          label: '내서재',
          icon: Icon(CupertinoIcons.book),
        ),
        const BottomNavigationBarItem(
          label: '검색',
          icon: Icon(CupertinoIcons.search),
        ),
        const BottomNavigationBarItem(
          label: '설정',
          icon: Icon(CupertinoIcons.settings),
        ),
      ],
    );
  }
}
