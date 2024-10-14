import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_list_item.dart';
import 'package:bookbox/ui/main/library/favorite_tab/favorite_tab_vm.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: gap_s),
      child: ListView(
        children: [
          SizedBox(height: 35), // 필요시 정렬버튼 들어갈 자리
          ...BookList.map((book) {
            return CustomListItem(
              theme: theme,
              book: book,
            );
          }).toList(),
        ],
      ),
    );
  }
}
