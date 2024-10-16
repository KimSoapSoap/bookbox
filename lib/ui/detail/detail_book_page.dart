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
    final List<String> titles = ['제목 1', '제목 2', '제목 3'];
    final List<String> bodies = ['내용 1', '내용 2', '내용 3'];

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
