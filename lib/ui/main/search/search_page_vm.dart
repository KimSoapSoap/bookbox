import 'package:bookbox/data/repository/main/search/serach_repository.drt.dart';
import 'package:bookbox/ui/main/library/_components/library_book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ViewModel
class SearchPageViewModel extends StateNotifier<SearchPageState> {
  SearchPageViewModel() : super(SearchPageState());

  Future<void> loadSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedSearches = prefs.getStringList('recent_searches');
    if (storedSearches != null) {
      state = state.copyWith(
        recentSearches: storedSearches
            .map((s) => {
                  'word': s.split('|')[0],
                  'date': s.split('|')[1],
                })
            .toList(),
      );
    }
  }

  Future<void> saveSearch(String word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final date = DateTime.now().toString().split(' ')[0];

    // 중복된 검색어가 있는지 확인하고 제거
    List<Map<String, String>> filteredSearches =
        state.recentSearches.where((search) => search['word'] != word).toList();

    // 새로운 검색어 추가
    List<Map<String, String>> updatedSearches = [
      {'word': word, 'date': date},
      ...filteredSearches,
    ];

    // 검색어 리스트가 20개를 넘으면 마지막 항목 제거
    if (updatedSearches.length > 20) {
      updatedSearches.removeLast();
    }

    // 검색어와 날짜를 'word|date' 형태로 변환하여 저장
    List<String> storedSearches =
        updatedSearches.map((s) => '${s['word']}|${s['date']}').toList();
    await prefs.setStringList('recent_searches', storedSearches);

    // 상태 업데이트
    state = state.copyWith(recentSearches: updatedSearches);
  }

  Future<void> deleteSearch(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> updatedSearches = [...state.recentSearches];
    updatedSearches.removeAt(index);
    List<String> storedSearches =
        updatedSearches.map((s) => '${s['word']}|${s['date']}').toList();
    await prefs.setStringList('recent_searches', storedSearches);

    state = state.copyWith(recentSearches: updatedSearches);
  }

  Future<void> deleteAllSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
    state = state.copyWith(recentSearches: []);
  }

  void performSearch(String keyword) async {
    List<dynamic> jsonList =
        await SearchRepository.instance.findAllByKeyword(keyword);
    List<Book> bookList = jsonList.map((e) => Book.fromMap(e)).toList();
    print(bookList);

    state = state.copyWith(
      searchResults: bookList,
      resultSize: bookList.length,
      isSearching: true,
    );
  }
}

// State 클래스
class SearchPageState {
  final List<Map<String, String>> recentSearches;
  final List<Book> searchResults;
  final int resultSize;
  final bool isSearching;

  SearchPageState({
    this.recentSearches = const [],
    this.searchResults = const [],
    this.resultSize = 0,
    this.isSearching = false,
  });

  SearchPageState copyWith({
    List<Map<String, String>>? recentSearches,
    List<Book>? searchResults,
    int? resultSize,
    bool? isSearching,
  }) {
    return SearchPageState(
      recentSearches: recentSearches ?? this.recentSearches,
      searchResults: searchResults ?? this.searchResults,
      resultSize: resultSize ?? this.resultSize,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

// Provider
final searchPageProvider =
    StateNotifierProvider<SearchPageViewModel, SearchPageState>(
        (ref) => SearchPageViewModel()..loadSearches());
