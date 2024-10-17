import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/main/search/_components/search_page_list_item.dart';
import 'package:bookbox/ui/main/search/search_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPageBody extends ConsumerWidget {
  const SearchPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchPageProvider);
    final viewModel = ref.read(searchPageProvider.notifier);
    TextTheme theme = lightTextTheme();
    TextEditingController searchController = TextEditingController();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (String value) {
              if (value.isEmpty) {
                viewModel.state = viewModel.state.copyWith(isSearching: false);
              }
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: '         책 제목 / 저자명 / 출판사',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.deepPurpleAccent, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.deepPurpleAccent, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (searchController.text.isNotEmpty) {
                    viewModel.saveSearch(searchController.text);
                    viewModel.performSearch(searchController.text);
                  } else {
                    viewModel.state =
                        viewModel.state.copyWith(isSearching: true);
                  }
                },
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  searchController.text = '';
                  viewModel.state =
                      viewModel.state.copyWith(isSearching: false);
                },
              ),
            ),
          ),
        ),
        if (state.isSearching)
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '검색 결과: ${state.resultSize}건',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (state.resultSize == 0)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 150.0),
                child: Text(
                  '검색 결과가 없습니다',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.searchResults.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SearchPageListItem(
                      theme: theme,
                      book: state.searchResults[index],
                    ),
                  ],
                );
              },
            ),
          ])
        else if (state.recentSearches.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '최근 검색어',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.deleteAllSearches();
                      },
                      child: const Text('전체 삭제'),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.recentSearches.length,
                itemBuilder: (context, index) {
                  final search = state.recentSearches[index];
                  return InkWell(
                    onTap: () {
                      searchController.text = search['word'] ?? '';
                    },
                    child: ListTile(
                      title: Text(search['word'] ?? ''),
                      subtitle: Text(search['date'] ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          viewModel.deleteSearch(index);
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          )
        else
          const Center(
            child: Text('저장된 검색어가 없습니다'),
          ),
      ],
    );
  }
}
