import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:bookbox/ui/main/home/cate_tab/cate_tab_vm.dart';
import 'package:flutter/material.dart';

class UptodateTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.5;
    return Padding(
      padding: const EdgeInsets.all(gap_s),
      child: ListView(
        children: [
          Text(
            '업데이트 된 책들을 만나 보세요!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text('최근 3개월 간 등록된 도서들이 나옵니다.'),
          SizedBox(
            height: gap_m,
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemCount: BookList.length,
            itemBuilder: (context, index) {
              final book = BookList[index];
              return InkWell(
                onTap: () {
                  // 책 클릭 시 isbn13 출력
                  print('클릭했니: ${book.isbn13}');
                },
                child: CustomCardItem(
                  imageUrl: book.cover,
                  title: book.title,
                  author: book.author,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
