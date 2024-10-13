import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:bookbox/ui/detail/components/detail_header.dart';
import 'package:bookbox/ui/detail/components/detail_panel.dart';
import 'package:flutter/material.dart';

class DetailBookPage extends StatefulWidget {
  final String isbn13;

  DetailBookPage(this.isbn13);

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  List<bool> _isOpen = [false, false, false];
  final List<String> titles = ['제목 1', '제목 2', '제목 3'];
  final List<String> bodies = ['내용 1', '내용 2', '내용 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              DetailHeader(),
              const _boxGap(),
              Container(
                padding: EdgeInsets.all(gap_m), // 패딩 추가
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          '11554명이 읽고 있어요',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: gap_s),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('파일형식: EPUB'),
                                Text('글자수: 약 40.6만 자'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('듣기가능: TTS 지원'),
                                Text('용량: 11.89MB'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: gap_m),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: SECONDARY_COLOR,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                )),
                            onPressed: () {},
                            child: Text(
                              '독서감상문 쓰기',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: gap_m),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '책 소개',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '핵 플렉스 원리 기반, 상징적인 모험과의 충돌. 한 편에 네 번의 복수가 담기는 곳!',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const _boxGap(),
              for (int i = 0; i < titles.length; i++)
                Column(
                  children: [
                    DetailPanel(
                      isOpen: _isOpen[i],
                      togglePanel: () => _togglePanel(i),
                      title: titles[i], // 제목 전달
                      body: bodies[i], // 내용 전달
                    ),
                    const _boxGap(),
                  ],
                ),
              SingleChildScrollView(
                padding: EdgeInsets.all(gap_m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이 분야 인기 도서',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: gap_m),
                    // 책들이 가로로 나열됩니다.
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: gap_m),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print('책 제목 ${index + 1} 클릭됨');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: Image.network(
                                      "https://picsum.photos/id/${240 + index}/200/280",
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: 100,
                                  child: Text(
                                    '책 제목 ${index + 1} 아주 긴 제목이 될 수도 있습니다',
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              _boxGap(),
              SizedBox(height: 90),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), // 왼쪽 상단 둥글게
                  topRight: Radius.circular(10), // 오른쪽 상단 둥글게
                ),
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 2),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(gap_m),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue, // 원하는 배경색으로 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () {
                        // 대여하기 버튼 클릭 시 동작
                        print('대여하기 클릭됨');
                      },
                      child: Text(
                        '대여하기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // 버튼 간격 추가
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.blue), // 원하는 배경색으로 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () {
                        // 예약하기 버튼 클릭 시 동작
                        print('예약하기 클릭됨');
                      },
                      child: Text(
                        '예약하기',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 패널 상태 변경 메서드
  void _togglePanel(int index) {
    setState(() {
      _isOpen[index] = !_isOpen[index]; // 특정 인덱스의 패널만 토글
    });
  }
}

class _boxGap extends StatelessWidget {
  const _boxGap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: gap_s, // 원래 SizedBox에 주었던 높이
      color: Colors.grey[200], // 회색 배경
    );
  }
}
