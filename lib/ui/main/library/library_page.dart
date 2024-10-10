import 'package:bookbox/ui/main/library/history_tab/history_tab.dart';
import 'package:bookbox/ui/main/library/lend_tab/lend_tab.dart';
import 'package:bookbox/ui/main/library/reserve_tab/reserve_tab.dart';
import 'package:bookbox/ui/main/library/review_tab/review_tab.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
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
    print("내서재 그림");
    return Column(
      children: [
        TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab, // 글자 말고 탭 길이 추구
          controller: tabController,
          tabs: [
            Tab(text: '대여중'),
            Tab(text: '예약중'),
            Tab(text: '리뷰'),
            Tab(text: '대여 기록'),
          ],
        ),
        // Expanded로 TabBarView를 감싸서 화면 전환 지원
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              LendTab(),
              ReserveTab(),
              ReviewTab(),
              HistoryTab(),
            ],
          ),
        ),
      ],
    );
  }
}
