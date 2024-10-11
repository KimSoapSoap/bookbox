import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_panel.dart';
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
                return _cateItem(
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

class _cateItem extends StatelessWidget {
  _cateItem({
    super.key,
    required this.theme,
    required this.book,
  });

  final TextTheme theme;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('책Id : ${book.isbn13}');
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[400]!), // 하단 경계 설정
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 제목 정렬
              children: [
                Image.network(
                  book.cover, // 이미지 URL (예시)
                  height: 150,
                  width: 100, // 이미지 너비를 전체로 설정
                  fit: BoxFit.cover, // 이미지 비율 유지
                ),
                SizedBox(width: 8), // 이미지와 제목 간의 간격
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: theme.bodyLarge,
                      ),
                      SizedBox(height: 4), // 저자와 설명 사이의 간격
                      Text(
                        book.description ?? '', // 설명 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4), // 제목과 저자 사이의 간격
                      Text(
                        book.author, // 저자 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
