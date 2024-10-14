import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/detail/components/detail_btn.dart';
import 'package:bookbox/ui/detail/components/detail_header.dart';
import 'package:bookbox/ui/detail/components/detail_info.dart';
import 'package:bookbox/ui/detail/components/detail_panel.dart';
import 'package:bookbox/ui/detail/components/popular_books.dart';
import 'package:flutter/material.dart';

class DetailBookPage extends StatefulWidget {
  final String isbn13;

  DetailBookPage(this.isbn13);

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  List<bool> _isOpen = [false, false, false];
  final List<String> titles = ['제목 1', '제목 2', '제목 3'];
  final List<String> bodies = ['내용 1', '내용 2', '내용 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              DetailHeader(),
              const _boxGap(),
              DetailInfo(),
              const _boxGap(),
              ...titles.asMap().entries.map((entry) {
                int index = entry.key;
                return Column(
                  children: [
                    DetailPanel(
                      isOpen: _isOpen[index],
                      togglePanel: () => _togglePanel(index),
                      title: entry.value,
                      body: bodies[index],
                    ),
                    const _boxGap(),
                  ],
                );
              }).toList(),
              PopularBooks(),
              _boxGap(),
              SizedBox(height: 90),
            ],
          ),
          DetailButtons(),
        ],
      ),
    );
  }

  // 패널 상태 변경 메서드
  void _togglePanel(int index) {
    setState(() {
      _isOpen[index] = !_isOpen[index]; // 특정 인덱스의 패널만 토글
    });
  }
}

class _boxGap extends StatelessWidget {
  const _boxGap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: gap_s, // 원래 SizedBox에 주었던 높이
      color: Colors.grey[200], // 회색 배경
    );
  }
}
