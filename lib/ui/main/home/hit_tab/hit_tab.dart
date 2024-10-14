import 'dart:ui';
import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_list_item.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart';
import 'package:flutter/material.dart';

class HitTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();

    return Padding(
      padding: const EdgeInsets.all(gap_s),
      child: Stack(
        children: [
          ListView(
            children: [
              Text(
                '✨인기 책들을 만나 보세요!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              ...BookList.map((book) {
                return CustomListItem(
                  theme: theme,
                  book: book,
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
