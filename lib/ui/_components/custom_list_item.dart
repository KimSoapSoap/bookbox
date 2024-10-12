import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:flutter/material.dart';

abstract class BookBase {
  String get isbn13;

  String get title;

  String get author;

  String? get description;

  String get cover;

  bool? lendStatus;
  int? reservationCount;
}

class CustomListItem extends StatelessWidget {
  final TextTheme theme;
  final BookBase book;

  const CustomListItem({
    super.key,
    required this.theme,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    print(book.lendStatus.toString());
    return InkWell(
      onTap: () {
        print('책Id : ${book.isbn13}');
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[400]!), // 하단 경계 설정
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 제목 정렬
              children: [
                Image.network(
                  book.cover, // 이미지 URL (예시)
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
                        book.title,
                        style: theme.bodyLarge,
                      ),
                      const SizedBox(height: 4), // 저자와 설명 사이의 간격
                      Text(
                        book.description ?? '', // 설명 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4), // 제목과 저자 사이의 간격
                      Text(
                        book.author, // 저자 텍스트
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      _lendStatus(context),
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

  Widget _lendStatus(BuildContext context) {
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
        _reservation(context)
      ]);
    }
    if (book.lendStatus == false) {
      return InkWell(
        child: Text(
          '대여 가능',
          style: TextStyle(
            fontSize: 15,
            color: PRIMARY_COLOR,
          ),
        ),
        onTap: () {
          print('대여 로직');
          CustomDialog(
              title: '대여 확인',
              content: '책을 대여 하시겠습니까?',
              onConfirm: () => {
                    print("확인 선택시 대여 로직 실행"),
                  }).show(context);
        },
      );
    }
    return SizedBox.shrink();
  }

  Widget _reservation(BuildContext context) {
    if (book.reservationCount == null) {
      return SizedBox.shrink();
    }
    if (book.reservationCount! < 3) {
      return InkWell(
        child: Text(
          '예약 가능',
          style: TextStyle(
            fontSize: 15,
            color: SECONDARY_COLOR,
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
