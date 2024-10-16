import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:bookbox/ui/_components/custom_floating_btn.dart';
import 'package:flutter/material.dart';

class ReserveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.8;
    final double itemWidth = size.width / 2.5;

    return Padding(
      padding: const EdgeInsets.all(gap_s),
      child: ListView(
        children: [
          SizedBox(height: 35), // 필요시 정렬버튼 들어갈 자리
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
              return Stack(children: [
                Column(children: [
                  CustomCardItem(
                    imageUrl: "https://picsum.photos/id/${index + 10}/200/280",
                    // 이미지 URL
                    title: "책 제목\n2줄일 때", // 책 제
                  ),
                  SizedBox(height: 5),
                  Text(
                    '예약 순번 : 1',
                    style: TextStyle(fontSize: 12),
                  ),
                ]),
                Positioned(
                    right: -5,
                    top: 0,
                    child: CustomFloatingButton(actions: [
                      ListTile(title: Text('책 이름 $index')),
                      ListTile(
                        title: Text('정보'),
                        onTap: () {
                          Navigator.pop(context);
                          // 상세 보기 페이지로 이동
                        },
                      ),
                      ListTile(
                        title: Text('예약 취소'),
                        onTap: () {
                          Navigator.pop(context);
                          CustomDialog(
                            title: '예약 취소',
                            content: '책 $index 예약을 취소하시겠습니까?',
                            onConfirm: () {
                              //예약 취소 로직
                              print('책 $index 예약 취소됨');
                            },
                          ).show(context);
                        },
                      ),
                    ]))
              ]);
            },
          ),
        ],
      ),
    );
  }
}
