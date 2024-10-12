import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_action_btn.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:flutter/material.dart';

class ReserveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = textTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.8;
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
              crossAxisSpacing: 25,
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Column(children: [
                CustomCardItem(
                  imageUrl:
                      "https://picsum.photos/id/${index + 10}/200/280", // 이미지 URL
                  title: "책 제목\n2줄일 때", // 책 제
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomActionButton(
                        text: '취소',
                        backgroundColor: Colors.orangeAccent,
                        onPressed: () {
                          CustomDialog(
                              title: '예약 취소 확인',
                              content: '$index번 책 예약을 취소 하시겠습니까?',
                              onConfirm: () => {
                                    print("$index번 책 확인 선택시 실행 로직"),
                                  }).show(context);
                        }),
                    CustomActionButton(
                        text: '정보',
                        textColor: PRIMARY_COLOR,
                        backgroundColor: Colors.white38,
                        onPressed: () {
                          //상세 페이지 이동 로직
                          print('상세페이지 드가자');
                        }),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '예약 순번 : 1',
                  style: TextStyle(fontSize: 12),
                ),
              ]);
            },
          ),
        ],
      ),
    );
  }
}
