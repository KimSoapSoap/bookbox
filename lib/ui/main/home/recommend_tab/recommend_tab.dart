import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/_components/custom_card_item.dart';
import 'package:flutter/material.dart';

class RecommendTab extends StatelessWidget {
  final ScrollController scrollController;

  const RecommendTab({Key? key, required this.scrollController})
      : super(key: key);

  // 비동기적으로 이미지 로드하는 메서드
  Future<List<String>> loadImages() async {
    List<String> imageUrls = [];
    for (int i = 0; i < 12; i++) {
      imageUrls.add("https://picsum.photos/id/${i + 10}/200/280");
      // 여기서 필요한 로드 지연을 추가할 수 있습니다.
      await Future.delayed(Duration(milliseconds: 100)); // 100ms 지연
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = lightTextTheme();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.5;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(gap_s),
        child: FutureBuilder<List<String>>(
          future: loadImages(), // 비동기 작업 실행
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 로딩 중일 때 스피너 표시
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
                ),
              );
            } else if (snapshot.hasData) {
              // 이미지 로드가 완료된 경우 GridView 표시
              List<String> imageUrls = snapshot.data!;
              return ListView(
                controller: scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: gap_s), // 아래 간격 조정
                    child: Text(
                      "00님\nBookBox 에서 추천하는 책을 만나보세요.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // 그리드 스크롤 비활성화
                    shrinkWrap: true,
                    // 그리드의 높이를 내용에 맞게 조절
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      childAspectRatio: (itemWidth / itemHeight),
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return CustomCardItem(
                        imageUrl: imageUrls[index], // 로드된 이미지 URL
                        title: "책 제목\n제목길면청길면 $index", // 책 제목
                        author: "저자이름 $index 엄청길면", // 저자 이름
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(child: Text('데이터가 없습니다.'));
            }
          },
        ),
      ),
    );
  }
}
