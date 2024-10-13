import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:bookbox/ui/_components/custom_floating_btn.dart';
import 'package:flutter/material.dart';

class LendTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
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
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      print('책 클릭 $index');
                    },
                    child: Column(children: [
                      CustomCardItem(
                        imageUrl:
                            "https://picsum.photos/id/${index + 10}/200/280",
                        // 이미지 URL
                        title: "책 제목\n2줄일 때", // 책 제
                      ),
                      Text(
                        '기한: 24-10-20',
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                  ),
                  Positioned(
                    right: -5,
                    top: 0,
                    child: CustomFloatingButton(
                      actions: [
                        ListTile(title: Text('책 이름 $index')),
                        ListTile(
                            title: Text('정보'),
                            onTap: () {
                              Navigator.pop(context);
                              print('책 상세정보로 이동');
                            }),
                        ListTile(
                          title: Text('연장'),
                          onTap: () {
                            Navigator.pop(context); //하단 모달창 닫아주려고 씀
                            CustomDialog(
                                title: '연장 확인',
                                content: '$index번 책을 연장 하시겠습니까?',
                                onConfirm: () => {
                                      print("$index번 책 확인 선택시 연장 로직 실행"),
                                    }).show(context);
                          },
                        ),
                        ListTile(
                          title: Text('반납'),
                          onTap: () {
                            Navigator.pop(context);
                            CustomDialog(
                                title: '반납 확인',
                                content: '$index번 책을 반납 하시겠습니까?',
                                onConfirm: () => {
                                      print("$index번 책 확인 선택시 반납 로직 실행"),
                                    }).show(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
