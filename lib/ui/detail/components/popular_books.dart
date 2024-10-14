import 'package:bookbox/core/constants/size.dart';
import 'package:flutter/material.dart';

class PopularBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                            border: Border.all(color: Colors.grey, width: 1),
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
                          style: TextStyle(fontSize: 12),
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
    );
  }
}
