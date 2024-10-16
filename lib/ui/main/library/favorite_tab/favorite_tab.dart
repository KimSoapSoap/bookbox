import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/main/home/_components/home_Indicator.dart';
import 'package:bookbox/ui/main/library/_components/library_list_item.dart';
import 'package:bookbox/ui/main/library/favorite_tab/favorite_tab_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme theme = lightTextTheme();

    FavoriteModel? model = ref.watch(favoriteProvider);

    if (model == null) {
      return CustomCircularProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: gap_s),
        child: ListView(
          children: [
            SizedBox(height: 35), // 필요시 정렬버튼 들어갈 자리
            ...model.list.map((book) {
              return LibraryListItem(
                theme: theme,
                book: book,
              );
            }).toList(),
          ],
        ),
      );
    }
  }
}
