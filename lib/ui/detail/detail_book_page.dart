import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/detail/components/detail_btn.dart';
import 'package:bookbox/ui/detail/components/detail_header.dart';
import 'package:bookbox/ui/detail/components/detail_info.dart';
import 'package:bookbox/ui/detail/components/detail_panel.dart';
import 'package:bookbox/ui/detail/components/detail_vm.dart';
import 'package:bookbox/ui/detail/components/popular_books.dart';
import 'package:bookbox/ui/main/home/_components/home_Indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PanelStateNotifier extends StateNotifier<List<bool>> {
  PanelStateNotifier() : super([false, false, false]);

  void togglePanel(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) !state[i] else state[i],
    ];
  }
}

final panelStateProvider =
    StateNotifierProvider<PanelStateNotifier, List<bool>>(
  (ref) => PanelStateNotifier(),
);

class DetailBookPage extends ConsumerWidget {
  final String isbn13;

  DetailBookPage(this.isbn13, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널 상태를 가져오고 업데이트하는 provider 접근
    final panelStates = ref.watch(panelStateProvider);
    final panelNotifier = ref.read(panelStateProvider.notifier);

    final detailModel = ref.watch(detailProvider(isbn13));
    // 패널에 표시할 데이터
    final List<String> titles = ['책소개', '목차', '저자 및 역자 소개'];
    final List<String> bodies = [
      '평화와 질서가 있는 밝은 세계에 살던 싱클레어는 불량소년 프란츠 크로머에게 거짓말을 했다가 지속해서 돈을 빼앗기고 괴롭힘 당한다. 자신이 금지된 어두운 세계에 발을 들인 것에 괴로워하는 싱클레어를 신비로운 전학생 막스 데미안이 구해주고, 카인과 아벨, 선과 악, 빛과 어둠 등 지금까지 의심 없이 받아들였던 이원적인 종교관을 새롭게 해석하도록 이끌어준다. 이후 라틴어 학교를 졸업하고 데미안과 헤어져, 다시 어두운 세계를 방황하는 싱클레어에게 어느 날 ‘아브락사스’라는 신의 이름이 담긴 데미안의 기묘한 쪽지가 도착하는데….',
      '데미안 \n1 - 두 세계\n2 - 카인\n3 - 도둑\n4 - 베아트리체\n5 - 새는 알에서 나오려고 투쟁한다\n6 - 야곱의 씨름\n7 - 에바 부인\n8 - 종말의 시작\n작품 해설 《데미안》, 자아 성찰의 여로를 그리다',
      '독일 남부 뷔르템베르크의 칼프에서 태어났다. 아버지 요하네스는 목사였고, 어머니 역시 독실한 신학자 가문 출신이라 기독교적 분위기 속에서 어린 시절을 보냈다. 1890년 라틴어 학교에 입학했고, 이듬해 마울브론 신학교에 들어갔다. 하지만 신학교의 속박된 생활을 못 견디고 뛰쳐나와 한때 자살을 시도했다. 시인이 되기를 꿈꾼 뒤 시계 공장에서 시계 톱니바퀴를 닦으며 문학수업을 시작했다. 1895년 낭만주의 문학에 심취해 첫 시집 《낭만적인 노래》를 출간했다. 1904년 첫 장편소설 《페터 카멘친트》를 출간하여 문학적 지위를 얻었다. 그해에 피아니스트 마리아 베르누이와 결혼했으며, 스위스로 이주해 시작에 몰두했다. 그 후 인도 여행으로 동양에 대한 관심이 깊어졌으며, 아내의 정신병, 헤세 자신의 신병 등 가정적 위기를 겪었고, 제2차 세계대전 중 나치스의 광적인 폭정에 저항하는 등 파란 많은 세월을 겪었다. 주요 작품으로 《수레바퀴 밑에서》, 《게르트루트》, 《크눌프》, 《데미안》, 《싯다르타》, 《나르치스와 골트문트》, 《유리알 유희》(1946년 노벨문학상 수상작) 등이 있다.'
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: detailModel == null
          ? CustomCircularProgressIndicator()
          : Stack(
              children: [
                ListView(
                  children: [
                    DetailHeader(book: detailModel.book),
                    const _boxGap(),
                    DetailInfo(book: detailModel.book),
                    const _boxGap(),
                    ...titles.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Column(
                        children: [
                          DetailPanel(
                            isOpen: panelStates[index],
                            togglePanel: () => panelNotifier.togglePanel(index),
                            title: entry.value,
                            body: bodies[index],
                          ),
                          const _boxGap(),
                        ],
                      );
                    }).toList(),
                    PopularBooks(),
                    _boxGap(),
                    SizedBox(height: 90),
                  ],
                ),
                DetailButtons(),
              ],
            ),
    );
  }
}

class _boxGap extends StatelessWidget {
  const _boxGap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: gap_s,
      color: Colors.grey[200],
    );
  }
}
