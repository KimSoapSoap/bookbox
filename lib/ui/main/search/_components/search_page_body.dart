import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/book_base.dart';
import 'package:bookbox/ui/main/search/_components/search_page_list_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../search_page_vm.dart';

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({super.key});

  @override
  _SearchPageBodyState createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  List<Map<String, String>> recentSearches = [];
  List<BookBase> searchResults = []; // 검색 결과를 저장할 리스트
  int resultSize = 0;
  TextEditingController searchController = TextEditingController();

  // 검색 중인지 확인하는 플래그
  // 이게 true면 검색결과 창이 표시되고 false면 최근 검색어 칸이 표시되게 해놨다.
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadSearches(); // 저장된 검색어 불러오기
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (String value) {
              //검색어를 다 지웠으면 최근 검색어 나오도록
              if (value.length == 0) {
                setState(() {
                  isSearching = false;
                });
              }
            },
            controller: searchController,
            decoration: InputDecoration(
                hintText: '         책 제목 / 저자명 / 출판사',
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (searchController.text.isNotEmpty) {
                      _saveSearch(searchController.text);

                      //검색 로직
                      _performSearch(searchController.text);
                    } else {
                      //검색어 입력 안 하고 검색 누르면 검색결과창 다시 보임
                      setState(() {
                        isSearching = true;
                      });
                    }
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () {
                    searchController.text = '';
                    setState(() {
                      isSearching = false;
                    });
                  },
                )),
          ),
        ),

        // Flexible 대신 ListView로 처리하여 스크롤 가능하게 설정
        if (isSearching) // 검색 중이면 검색 결과 출력
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '검색 결과: $resultSize건',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (resultSize == 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 150.0),
                child: Text('검색 결과가 없습니다', // 표시할 텍스트
                    style: TextStyle(
                      fontSize: 16, // 텍스트 크기
                      color: Colors.grey, // 텍스트 색상
                    )),
              ),
            ListView.builder(
              //부모가 ListView이거나 할 때 그 내부에 또 ListView가 있으면 shrinkWrap: true 를 붙여주자.
              shrinkWrap: true, // 부모 위젯의 제약을 따르도록 설정
              physics: const NeverScrollableScrollPhysics(), // 스크롤 동작 제어
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SearchPageListItem(
                      theme: theme,
                      book: searchResults[index],
                    ),
                  ], // 검색 결과 출력
                );
              },
            ),
          ])
        else if (recentSearches.isNotEmpty)
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
                        _deleteAllSearches(); // 전체 삭제
                      },
                      child: const Text('전체 삭제'),
                    ),
                  ],
                ),
              ), // 검색 중이 아니면 최근 검색어 출력
              ListView.builder(
                shrinkWrap: true, // 부모 위젯의 제약을 따르도록 설정
                physics: const NeverScrollableScrollPhysics(), // 스크롤 동작 제어
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  final search = recentSearches[index];
                  return InkWell(
                    onTap: () {
                      searchController.text =
                          search['word'] ?? ''; // Null일 경우 빈 문자열
                    },
                    child: ListTile(
                      title: Text(search['word'] ?? ''), // Null일 경우 기본값 설정
                      subtitle: Text(search['date'] ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _deleteSearch(index);
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

  Future<void> _loadSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedSearches = prefs.getStringList('recent_searches');
    if (storedSearches != null) {
      setState(() {
        recentSearches = storedSearches
            .map((s) => {
                  'word': s.split('|')[0],
                  'date': s.split('|')[1],
                })
            .toList();
      });
    }
  }

  //검색어 저장 -> shared_preferences 라이브러리 필요
  Future<void> _saveSearch(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final date = DateTime.now().toString().split(' ')[0];

    setState(() {
      //최근 검색어가 위에 오도록 index 0에 넣음
      recentSearches.insert(0, {'word': word, 'date': date});
    });

    // 검색어가 20개를 초과하면 마지막 요소 삭제
    if (recentSearches.length > 20) {
      recentSearches.removeLast();
    }

    List<String> storedSearches =
        recentSearches.map((s) => '${s['word']}|${s['date']}').toList();
    await prefs.setStringList('recent_searches', storedSearches);
  }

  Future<void> _deleteSearch(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches.removeAt(index);
    });
    List<String> storedSearches =
        recentSearches.map((s) => '${s['word']}|${s['date']}').toList();
    await prefs.setStringList('recent_searches', storedSearches);
  }

  Future<void> _deleteAllSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
    setState(() {
      recentSearches.clear();
    });
  }

  // 검색 기능
  void _performSearch(String query) {
    //query(검색어)를 전달 받고 api서버에 요청
    //요청하고 searchResults에 bookList를 받아 왔다고 가정

    searchResults = bookList;
    resultSize = bookList.length;
    setState(() {
      isSearching = true; // 검색 중으로 변경
    });
  }
}
