import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
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
    return Column(
      children: [
        TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          controller: tabController,
          tabs: [
            Tab(text: '대여중인 책'),
            Tab(text: '예약중인 책'),
            Tab(text: '나의 리뷰'),
            Tab(text: '대여 기록'),
          ],
        ),
        // Expanded로 TabBarView를 감싸서 화면 전환 지원
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              Center(child: Text('서재 탭 1 내용')),
              Center(child: Text('서재 탭 2 내용')),
              Center(child: Text('서재 탭 3 내용')),
              Center(child: Text('서재 탭 4 내용')),
            ],
          ),
        ),
      ],
    );
  }
}
