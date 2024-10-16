import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:bookbox/ui/_components/custom_floating_btn.dart';
import 'package:bookbox/ui/main/home/_components/home_Indicator.dart';
import 'package:bookbox/ui/main/library/reserve_tab/_components/reserve_card_item.dart';
import 'package:bookbox/ui/main/library/reserve_tab/reserve_tab_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReserveTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme theme = lightTextTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.8;
    final double itemWidth = size.width / 2.5;

    ReservationListModel? model = ref.watch(ReservationListProvider);

    if (model == null) {
      return CustomCircularProgressIndicator();
    } else {
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
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                return Stack(children: [
                  Column(children: [
                    ReserveCardItem(
                      cover: model.list[index].cover,
                      sequence: model.list[index].sequence,

                      // 이미지 URL
                      title: model.list[index].bookTitle, // 책 제
                    ),
                    SizedBox(height: 5),
                  ]),
                  Positioned(
                      right: -5,
                      top: 0,
                      child: CustomFloatingButton(actions: [
                        ListTile(
                            title: Text('책 이름 ${model.list[index].bookTitle}')),
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

                                  ref
                                      .read(ReservationListProvider.notifier)
                                      .cancelReservation(
                                          "${model.list[index].isbn13}");
                                }).show(context);
                            // 상태 무효화하여 새로고침 유도
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
}
