import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart';

class PanelBuilder extends ConsumerWidget {
  final TextTheme theme;
  final bool isOpen;
  final Function togglePanel;
  final List<Cate> cateList; // 카테고리 리스트 추가

  PanelBuilder({
    required this.theme,
    required this.isOpen,
    required this.togglePanel,
    required this.cateList, // cateList 전달
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod 상태에서 선택된 카테고리 ID를 읽어옴
    final selectedCategoryId = ref.watch(selectedCategoryProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[400]!),
        ),
      ),
      child: ExpansionPanelList(
        dividerColor: Colors.white,
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.all(0),
        children: [
          _buildExpansionPanel(
              ref, selectedCategoryId), // 카테고리 리스트와 선택된 카테고리 ID 전달
        ],
        expansionCallback: (panelIndex, isOpen) {
          togglePanel(); // 패널 상태 변경 메서드
        },
      ),
    );
  }

  // 개별 ExpansionPanel 빌드 메서드
  ExpansionPanel _buildExpansionPanel(
      WidgetRef ref, String? selectedCategoryId) {
    return ExpansionPanel(
      headerBuilder: (context, isOpen) {
        return Container(
          height: 20.0,
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: cateList.take(4).map((cate) {
              return _buildCategoryButton(
                  ref, cate.categoryName, cate.categoryId, selectedCategoryId);
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
            return _buildCategoryButton(
                ref, cate.categoryName, cate.categoryId, selectedCategoryId);
          }).toList(),
        ),
        padding: EdgeInsets.only(bottom: 16.0),
      ),
      isExpanded: isOpen,
    );
  }

  // 카테고리 버튼을 빌드하는 메서드
  Widget _buildCategoryButton(WidgetRef ref, String categoryName,
      String categoryId, String? selectedCategoryId) {
    final isSelected = selectedCategoryId == categoryId; // 클릭된 버튼인지 확인

    return InkWell(
      onTap: () async {
        // 클릭된 카테고리 ID를 Riverpod 상태에 저장
        ref.read(selectedCategoryProvider.notifier).state = categoryId;
        print('카테고리 ID: $categoryId');
        await ref.read(cateTabProvider.notifier).findCateTapFiler(categoryId);
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
