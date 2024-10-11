import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/components/custom_list_item.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_panel.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart';
import 'package:flutter/material.dart';

class CateTab extends StatefulWidget {
  @override
  _CateTabState createState() => _CateTabState();
}

class _CateTabState extends State<CateTab> {
  bool _isOpen = false; // 상태 변수 초기화

  @override
  Widget build(BuildContext context) {
    TextTheme theme = textTheme();

    return Padding(
      padding: const EdgeInsets.all(gap_s),
      child: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: gap_xl),
              ...BookList.map((book) {
                return CateItem(
                  theme: theme,
                  book: book,
                );
              }).toList(),
            ],
          ),
          Positioned(
            top: -5, // 필요에 따라 위치 조정
            left: 0,
            right: 0,
            child: PanelBuilder(
              theme: theme,
              isOpen: _isOpen,
              togglePanel: _togglePanel,
            ),
          ),
        ],
      ),
    );
  }

  // 패널 상태 변경 메서드
  void _togglePanel() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }
}
