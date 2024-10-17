import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:bookbox/ui/detail/detail_book_page.dart';
import 'package:bookbox/ui/main/library/_components/library_book.dart';
import 'package:bookbox/ui/main/library/favorite_tab/favorite_tab_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteListItem extends ConsumerWidget {
  final TextTheme theme;
  final Book book;

  const FavoriteListItem({
    super.key,
    required this.theme,
    required this.book,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FavoriteModel? model = ref.watch(favoriteProvider);
    print(book.lendStatus.toString());
    return InkWell(
      onTap: () {
        print('책Id : ${book.isbn13}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBookPage(book.isbn13 ?? ""),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[400]!), // 하단 경계 설정
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 제목 정렬
              children: [
                Image.network(
                  book.cover ?? "", // 이미지 URL (예시)
                  height: 150,
                  width: 100, // 이미지 너비를 전체로 설정
                  fit: BoxFit.cover, // 이미지 비율 유지
                ),
                const SizedBox(width: 8), // 이미지와 제목 간의 간격
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title ?? "",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4), // 저자와 설명 사이의 간격
                      Text(
                        book.description ?? '', // 설명 텍스트

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4), // 제목과 저자 사이의 간격
                      Text(
                        book.author!, // 저자 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      _lendStatus(context, ref, model!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lendStatus(BuildContext context, WidgetRef ref, FavoriteModel model) {
    if (book.lendStatus == true) {
      return Row(children: [
        Text(
          '대여 불가',
          style: TextStyle(
            fontSize: 15,
            color: ERROR_COLOR,
          ),
        ),
        SizedBox(width: 25),
        _reservation(context) //대여 불가시 예약 가능 여부
      ]);
    }
    if (book.lendStatus == false) {
      return InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(border: Border.all(color: PRIMARY_COLOR)),
            child: Text(
              '대여 가능',
              style: TextStyle(
                fontSize: 15,
                color: PRIMARY_COLOR,
              ),
            ),
          ),
          onTap: () {
            print('대여 로직');
            CustomDialog(
              title: '대여 확인',
              content: '책을 대여 하시겠습니까?',
              onConfirm: () {
                print("확인 선택시 대여 로직 실행");

                // 선택한 책의 ISBN13을 가져와 대여 처리
                ref.read(favoriteProvider.notifier).lendBook(book.isbn13 ?? "");
              },
            ).show(context);
          });
    }
    return SizedBox.shrink();
  }

  Widget _reservation(BuildContext context) {
    if (book.reservationCount == null) {
      return SizedBox.shrink();
    }
    if (book.reservationCount! < 3) {
      return InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(border: Border.all(color: SECONDARY_COLOR)),
          child: Text(
            '예약 가능',
            style: TextStyle(
              fontSize: 15,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
        onTap: () {
          print('예약 로직');
          CustomDialog(
              title: '예약 확인',
              content: '책을 예약 하시겠습니까?',
              onConfirm: () => {
                    print("확인 선택시 예약 로직 실행"),
                  }).show(context);
        },
      );
    } else {
      return Text(
        '예약 불가',
        style: TextStyle(
          fontSize: 15,
          color: ERROR_COLOR,
        ),
      );
    }
  }
}
