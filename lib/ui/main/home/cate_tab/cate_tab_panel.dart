import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_book_vm.dart';
import 'package:flutter/material.dart';

class PanelBuilder extends StatefulWidget {
  final TextTheme theme;
  final bool isOpen;
  final Function togglePanel;

  PanelBuilder({
    required this.theme,
    required this.isOpen,
    required this.togglePanel,
  });

  @override
  _PanelBuilderState createState() => _PanelBuilderState();
}

class _PanelBuilderState extends State<PanelBuilder> {
  // 클릭된 카테고리 ID를 저장할 변수
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[400]!),
        ),
      ),
      child: ExpansionPanelList(
        dividerColor: Colors.transparent,
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.all(0),
        children: [
          _buildExpansionPanel(),
        ],
        expansionCallback: (panelIndex, isOpen) {
          widget.togglePanel(); // 패널 상태 변경 메서드
        },
      ),
    );
  }

  // 개별 ExpansionPanel 빌드 메서드
  ExpansionPanel _buildExpansionPanel() {
    return ExpansionPanel(
      headerBuilder: (context, isOpen) {
        return Container(
          height: 20.0,
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: cateList.take(4).map((cate) {
              return _buildCategoryButton(cate.categoryName, cate.categoryId);
            }).toList(),
          ),
        );
      },
      body: Container(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: cateList.sublist(4).map((cate) {
            return _buildCategoryButton(cate.categoryName, cate.categoryId);
          }).toList(),
        ),
        padding: EdgeInsets.only(bottom: gap_s),
      ),
      isExpanded: widget.isOpen,
    );
  }

  // 카테고리 버튼을 빌드하는 메서드
  Widget _buildCategoryButton(String categoryName, int categoryId) {
    final isSelected = _selectedCategoryId == categoryId; // 클릭된 버튼인지 확인

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategoryId = categoryId; // 클릭된 카테고리 ID 저장
        });
        print('카테고리 ID: $categoryId');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.grey[400] : Colors.grey[200], // 클릭된 경우 색상 변경
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Text(
          categoryName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // 클릭된 경우 텍스트 색상 변경
          ),
        ),
      ),
    );
  }
}
