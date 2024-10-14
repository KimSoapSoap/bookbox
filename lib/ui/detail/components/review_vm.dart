// 1. 창고 (ViewModel)
// 2. 창고 데이터 (State)
class review {
  int reviewId;
  int userId;
  String username;
  String isbn13;
  String content;
  String createdAt;

  review({
    required this.reviewId,
    required this.userId,
    required this.username,
    required this.isbn13,
    required this.content,
    required this.createdAt,
  });
}

List<review> reviewList = [
  review(
      reviewId: 1,
      userId: 1,
      username: "ssar",
      isbn13: '9791187011590',
      content: '댓글1',
      createdAt: '2024-10-14'),
  review(
      reviewId: 2,
      userId: 2,
      username: "cos",
      isbn13: '9791187011590',
      content: '댓글2 길게길게~~~ 길게~길게~길게~길게~길게~길게~',
      createdAt: '2024-10-14'),
  review(
      reviewId: 3,
      userId: 3,
      username: "love",
      isbn13: '9791187011590',
      content: '댓글3',
      createdAt: '2024-10-14'),
  review(
      reviewId: 4,
      userId: 1,
      username: "ssar",
      isbn13: '9791187011590',
      content: '댓글4길게~길게~길게~길게~길게~길게~길게~길게~길게~',
      createdAt: '2024-10-14'),
];
// 3. 창고 관리자 (Provider)
