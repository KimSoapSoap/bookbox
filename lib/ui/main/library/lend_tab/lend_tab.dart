import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/components/custom_card_item.dart';
import 'package:flutter/material.dart';

class LendTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = textTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.5;

    return Padding(
      padding: const EdgeInsets.all(gap_s),
      child: ListView(
        children: [
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            // 그리드 스크롤 비활성화
            shrinkWrap: true,
            // 그리드의 높이를 내용에 맞게 조절
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return CustomCardItem(
                imageUrl:
                    "https://picsum.photos/id/${index + 10}/200/280", // 이미지 URL
                title: "책 제목\n제목길면청길면 $index", // 책 제목
                author: "저자이름 $index 엄청길면", // 저자 이름
              );
            },
          ),
        ],
      ),
    );
  }
}
