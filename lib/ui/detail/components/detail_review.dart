import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/core/utils/my_http.dart';
import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/detail/components/detail_vm.dart';
import 'package:bookbox/ui/detail/components/report_dialog.dart';
import 'package:bookbox/ui/detail/components/review_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailReview extends ConsumerWidget {
  final DetailBookInfo book;
  const DetailReview({required this.book, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(ReviewProvider(book.isbn13));

    return Scaffold(
      appBar: CustomAppBar(),
      body: model == null
          ? CircularProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(gap_m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          book.cover,
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: gap_s),
                      Center(
                        child: Text(
                          book.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          book.author,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                _reviewForm(book.isbn13, ref, context),
                _reviewList(book.isbn13, model.reviews, ref),
                // _moreReviewsButton(),
              ],
            ),
    );
  }

  // 리뷰 등록 폼
  Widget _reviewForm(String isbn13, WidgetRef ref, BuildContext context) {
    final _content = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: gap_s),
            Text('이 책을 평가해주세요!'),
            SizedBox(height: gap_s),
            TextFormField(
              controller: _content,
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                hintText:
                    '리뷰 작성 시 광고 및 욕설, 비속어나 타인을 비방하는 문구를 사용하시면 비공개될 수 있습니다.',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(ReviewProvider(isbn13).notifier)
                          .notifySave(isbn13, _content.text)
                          .then((_) {
                        // 저장이 완료되면 스낵바 표시 및 UI 갱신
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('리뷰가 성공적으로 등록되었습니다.')),
                        );
                      });
                    },
                    child: Text(
                      '리뷰 등록',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 댓글 리스트
  Widget _reviewList(String isbn13, List<Review> reviews, WidgetRef ref) {
    if (reviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(gap_m),
        child: Center(
          child: Text(
            '첫 번째 댓글을 달아보세요!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final reviewItem = reviews[index];
        return Column(
          children: [
            ListTile(
              title: Text(reviewItem.content),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewItem.nick),
                  SizedBox(width: gap_m),
                  Text(formatDate(reviewItem.createdAt)), // 작성 날짜 추가
                ],
              ),
              trailing: _reviewActions(
                  context, reviewItem, ref, isbn13), // 수정 및 삭제 버튼 추가
            ),
            Divider(), // 각 댓글을 구분하는 경계선
          ],
        );
      },
    );
  }

// 수정 및 삭제 버튼
  Widget _reviewActions(
      BuildContext context, Review reviewItem, WidgetRef ref, String isbn13) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (reviewItem.owner) ...[
          // 리뷰 소유자일 때 수정 및 삭제 버튼 표시
          IconButton(
            icon: Icon(Icons.edit, size: 16),
            onPressed: () {
              print('리뷰 수정: ${reviewItem.content}'); // 수정 로직 추가 필요
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 16),
            onPressed: () {
              ref
                  .read(ReviewProvider(isbn13).notifier)
                  .notifyDelete(reviewItem.id, isbn13);
            },
          ),
        ] else ...[
          // 리뷰 소유자가 아닐 때 더보기 아이콘 표시
          IconButton(
            icon: Icon(Icons.more_vert_sharp, size: 16),
            onPressed: () {
              showReportDialog(context);
            },
          ),
        ],
      ],
    );
  }
}
