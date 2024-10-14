import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/admin/bookmanagement/BookManagement.dart';
import 'package:bookbox/ui/admin/report/Report.dart';
import 'package:bookbox/ui/admin/usermanagement/UserManagement.dart';
import 'package:bookbox/ui/main/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int _currentTab = 0;
  var loadPages = [0];

  // 각 탭의 제목 리스트
  final List<String> titles = ['책 관리', '유저 관리', '신고', '설정'];

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
            loadPages.contains(0) ? const Bookmanagement() : Container(),
            loadPages.contains(1) ? const Usermanagement() : Container(),
            loadPages.contains(2) ? const Report() : Container(),
            loadPages.contains(3) ? const SettingPage() : Container(),
          ],
        ),
        bottomNavigationBar: _bottomNavigation());
  }

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      selectedFontSize: 10,
      unselectedFontSize: 10,
      type: BottomNavigationBarType.fixed,
      //다크모드에 선택색상 적용이 안돼서 그냥 수동으로
      selectedItemColor: Colors.blueAccent,

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
          label: '도서 관리',
          icon: Icon(CupertinoIcons.book_solid),
        ),
        const BottomNavigationBarItem(
          label: '유저 관리',
          icon: Icon(CupertinoIcons.person_3),
        ),
        const BottomNavigationBarItem(
          label: '신고',
          icon: Icon(CupertinoIcons.nosign),
        ),
        const BottomNavigationBarItem(
          label: '설정',
          icon: Icon(CupertinoIcons.settings),
        ),
      ],
    );
  }
}
