abstract class BookBase {
  String get isbn13;

  String get title;

  String get author;

  String get cover;

  String? pubDate;
  String? publisher;
  String? description;
  bool? lendStatus;
  int? reservationCount;
}
