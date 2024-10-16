import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_dialog.dart';
import 'package:bookbox/ui/_components/custom_floating_btn.dart';
import 'package:bookbox/ui/main/home/_components/home_Indicator.dart';
import 'package:bookbox/ui/main/library/_components/library_card_item.dart';
import 'package:bookbox/ui/main/library/lend_tab/lend_tab_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LendTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme theme = lightTextTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.8;
    final double itemWidth = size.width / 2.5;

    LendListModel? model = ref.watch(LendListProvider);

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
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        print('책 클릭 $index');
                      },
                      child: Column(children: [
                        LibraryCardItem(
                          cover: "${model.list[index].cover}",
                          // 이미지 URL
                          title: "${model.list[index].title}", // 책 제
                        ),
                      ]),
                    ),
                    Positioned(
                      right: -5,
                      top: 0,
                      child: CustomFloatingButton(
                        actions: [
                          ListTile(title: Text('${model.list[index].title}')),
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
}
