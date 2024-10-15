import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/admin/bookmanagement/BookManagement_vm.dart';
import 'package:bookbox/ui/admin/bookmanagement/bookedit/book_edit_page.dart';
import 'package:bookbox/ui/admin/bookmanagement/bookregister/book_add_page.dart';
import 'package:bookbox/ui/main/search/_components/search_page_list_item.dart';
import 'package:flutter/material.dart';

class BookManagementBody extends StatefulWidget {
  const BookManagementBody({super.key});

  @override
  State<BookManagementBody> createState() => _BookManagementBodyState();
}

class _BookManagementBodyState extends State<BookManagementBody> {
  List<Map<String, String>> recentSearches = [];
  List<Book> searchResults = []; // 검색 결과를 저장할 리스트
  int resultSize = 0;
  TextEditingController searchController = TextEditingController();
  TextTheme theme = lightTextTheme();

// 검색 중인지 확인하는 플래그
// 이게 true면 검색결과 창이 표시되고 false면 최근 검색어 칸이 표시되게 해놨다.
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(children: [
        ListView(
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
                    hintText: '보유 도서 검색 / 책 제목 / 저자명 / 출판사',
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                if (resultSize == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150.0),
                    child: Text('보유하지 않은 도서입니다.', // 표시할 텍스트
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
            else
              //여기에 관리중인 책 리스트
              Column(
                children: [
                  // 보유 도서 개수 표시
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "보유 도서: ${bookList.length}권",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 테이블 형식의 제목 열 (번호, 사진, 제목, 저자, 등록일, 기능)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      height: 5,
                      thickness: 2,
                    ),
                  ),
                  // 도서 목록
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final book = bookList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 12.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: Row(
                            children: [
                              // 숫자가 차지하는 공간 줄임
                              Expanded(
                                flex: 1,
                                child: Text(
                                  style: TextStyle(fontSize: 20),
                                  "${index + 1}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // 이미지가 차지하는 공간을 늘림
                              Expanded(
                                flex: 2,
                                child: Image.network(
                                  book.cover, // book.cover로 책의 이미지 URL을 받음
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              // 나머지 정보들이 차지하는 공간
                              Expanded(
                                flex: 5,
                                // flex 값을 늘려서 제목, 저자, 출판일이 더 많은 공간을 사용하게 함
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cuttingString(15, book.title),
                                      style: TextStyle(
                                          fontSize: 15), // 제목을 최대 10자로 제한
                                    ),
                                    Text(
                                      cuttingString(
                                          17, book.author), // 저자를 최대 10자로 제한
                                    ),
                                    Text(book.pubDate!),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        // 수정 기능
                                        print('$index 수정');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => BookEditPage(
                                                book: bookList[index]),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        // 삭제 기능
                                        print('$index 삭제');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookAddPage(),
                ),
              );
            },
            child: Icon(Icons.add, color: Colors.black),
          ),
        )
      ]),
    );
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

String cuttingString(int cutoff, String text) {
  return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
}
