import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/_components/custom_app_bar.dart';
import 'package:bookbox/ui/detail/components/review_vm.dart';
import 'package:flutter/material.dart';

class DetailReview extends StatefulWidget {
  const DetailReview({super.key});

  @override
  _DetailReviewState createState() => _DetailReviewState();
}

class _DetailReviewState extends State<DetailReview> {
  final ScrollController _scrollController = ScrollController();
  final int _reviewsToShow = 10; // 추가할 리뷰 수
  List<review> displayedReviews = []; // 보여줄 리뷰 리스트

  @override
  void initState() {
    super.initState();
    displayedReviews = reviewList.take(_reviewsToShow).toList(); // 초기 리뷰 설정
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(gap_m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    "https://picsum.photos/id/10/200/280",
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: gap_s),
                Center(
                  child: Text(
                    '불편한 편의점',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '김호연 저',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          _reviewForm(),
          _reviewList(),
          _moreReviewsButton(),
        ],
      ),
      floatingActionButton: _scrollToTopButton(), // 상단으로 가는 버튼 추가
    );
  }

  // 리뷰 등록 폼
  Widget _reviewForm() {
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
                      print('리뷰 남기기 클릭됨');
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
  Widget _reviewList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviewList.length,
      itemBuilder: (context, index) {
        final reviewItem = reviewList[index];
        return Column(
          children: [
            ListTile(
              title: Text(reviewItem.content),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewItem.username),
                  SizedBox(width: gap_m),
                  Text(reviewItem.createdAt), // 작성 날짜 추가
                ],
              ),
              trailing: _reviewActions(index), // 수정 및 삭제 버튼 추가
            ),
            Divider(), // 각 댓글을 구분하는 경계선
          ],
        );
      },
    );
  }

  // 수정 및 삭제 버튼
  Widget _reviewActions(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //if (_isUserReview())
        IconButton(
          icon: Icon(Icons.edit, size: 16),
          onPressed: () {
            print('리뷰 수정: ${reviewList[index].content}');
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, size: 16),
          onPressed: () {
            setState(() {
              reviewList.removeAt(index);
            });
            print('리뷰 삭제: ${reviewList[index].content}');
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert_sharp, size: 16),
          onPressed: () {
            _showReportDialog(context); // 신고 다이얼로그 표시
          },
        ),
      ],
    );
  }

  // 더 보기 버튼
  // 더 보기 버튼
  Widget _moreReviewsButton() {
    // 남은 리뷰 수 계산
    int remainingReviews = reviewList.length - displayedReviews.length;

    return TextButton(
      onPressed: remainingReviews > 0
          ? () {
              setState(() {
                // 더 많은 리뷰 추가
                int currentCount = displayedReviews.length;
                int nextCount = currentCount + _reviewsToShow;
                if (nextCount > reviewList.length) {
                  nextCount = reviewList.length; // 리뷰 수를 초과하지 않도록 조정
                }
                displayedReviews = reviewList.take(nextCount).toList();
              });
            }
          : null, // 리뷰가 없으면 버튼 비활성화
      child: Text(
        remainingReviews > 0 ? '리뷰 $remainingReviews 개 더보기' : '더 이상 리뷰가 없습니다.',
        style: TextStyle(
            color: remainingReviews > 0
                ? Colors.blue
                : Colors.grey), // 비활성화 시 색상 변경
      ),
    );
  }

  // 상단으로 가는 버튼
  Widget _scrollToTopButton() {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_upward),
      tooltip: '상단으로 가기',
      backgroundColor: Colors.blue, // 배경 색상
      foregroundColor: Colors.white, // 아이콘 색상
      elevation: 6, // 그림자 높이
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
      ),
    );
  }
}

// JWT를 확인하여 사용자의 리뷰인지 분기를 여기서 나누나...
bool _isUserReview() {
  // 예: return currentUserId == reviewItem.userId;
  return true; // 예시로 true를 반환합니다.
}

void _showReportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReportDialog();
    },
  );
}

// ReportDialog 클래스 수정
class ReportDialog extends StatefulWidget {
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String? _selectedReason;

  final List<String> _reasons = [
    '욕설',
    '스팸',
    '부적절한 콘텐츠',
    '혐오 발언',
    '위협',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('댓글 신고'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _reasons.map((reason) {
          return RadioListTile<String>(
            title: Text(reason),
            value: reason,
            groupValue: _selectedReason,
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
        TextButton(
          onPressed: () {
            if (_selectedReason != null) {
              print('신고 사유: $_selectedReason');
              // 신고 처리 로직 추가
            }
            Navigator.pop(context);
          },
          child: Text('신고'),
        ),
      ],
    );
  }
}
