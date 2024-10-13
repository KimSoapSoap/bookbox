import 'package:bookbox/ui/main/search/_components/search_page_body.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("검색 그림");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView(children: [
        SearchPageBody(),
      ]),
    );
  }
}
