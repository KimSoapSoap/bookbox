import 'package:bookbox/ui/detail/detail_book_page.dart';
import 'package:bookbox/ui/main/library/history_tab/history_tab_vm.dart';
import 'package:flutter/material.dart';

class HistoryListItem extends StatelessWidget {
  final TextTheme theme;
  final Lend lend;

  const HistoryListItem({
    super.key,
    required this.theme,
    required this.lend,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('책Id : ${lend.isbn13}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBookPage(lend.isbn13),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              lend.cover, // 이미지 URL
              height: 50,
              width: 30,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12), // 이미지와 텍스트 간 간격
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lend.title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // 제목 스타일
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '대여: ${lend.lendDate ?? ''}',
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '반납: ${lend.returnDate}',
                        style: theme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        lend.returnStatus == true ? '반납됨' : '대여중',
                        style: theme.bodyMedium?.copyWith(
                          color: lend.returnStatus == true
                              ? Colors.redAccent
                              : Colors.blue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
