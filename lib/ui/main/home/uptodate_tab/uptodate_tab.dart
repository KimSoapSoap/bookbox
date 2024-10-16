import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:bookbox/ui/main/home/_components/home_Indicator.dart';
import 'package:bookbox/ui/main/home/uptodate_tab/uptodate_tab_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UptodateTab extends ConsumerWidget {
  final ScrollController scrollController;

  const UptodateTab({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.5;

    UptodateTabModel? model = ref.watch(UptodateTabProvider);

    if (model == null) {
      return CustomCircularProgressIndicator();
    } else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(gap_s),
          child: ListView(
            controller: scrollController,
            children: [
              Text(
                '업데이트 된 책들을 만나 보세요!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                itemCount: model.books.length, // 모델의 책 개수에 따라 그리드뷰 생성
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  childAspectRatio: (itemWidth / itemHeight),
                ),
                itemBuilder: (context, index) {
                  var book = model.books[index]; // 책 리스트에서 현재 인덱스에 해당하는 책 가져오기
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
        ),
      );
    }
  }
}
