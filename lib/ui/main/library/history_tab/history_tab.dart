import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/main/library/history_tab/_components/history_list_item.dart';
import 'package:bookbox/ui/main/library/history_tab/history_tab_vm.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();
    int historySize = lendList.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: gap_s),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [Text('대여기록: $historySize건')],
            ),
          ),
          SizedBox(height: 5), // 필요시 정렬버튼 들어갈 자리
          ...lendList.map((lend) {
            return HistoryListItem(
              theme: theme,
              lend: lend,
            );
          }).toList(),
        ],
      ),
    );
  }
}
