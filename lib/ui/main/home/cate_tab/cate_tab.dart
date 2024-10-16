import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/main/home/_components/home_Indicator.dart';
import 'package:bookbox/ui/main/home/_components/home_list_item.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_panel.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CateTab extends ConsumerWidget {
  final ScrollController scrollController;

  const CateTab({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme theme = Theme.of(context).textTheme;
    CateTabModel? model = ref.watch(cateTabProvider);
    bool _isOpen = model?.isOpen ?? false;

    if (model == null) {
      return CustomCircularProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.all(gap_s),
        child: Stack(
          children: [
            ListView(
              controller: scrollController,
              children: [
                SizedBox(height: gap_xl),
                ...model.books.map((book) {
                  return HomeListItem(
                    book: book,
                    theme: theme,
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
                togglePanel: () => _togglePanel(ref),
                cateList: model.cates,
              ),
            ),
          ],
        ),
      );
    }
  }

  void _togglePanel(WidgetRef ref) {
    ref.read(cateTabProvider.notifier).openAndClosePanel(); // 패널 열림/닫힘 토글
  }
}
