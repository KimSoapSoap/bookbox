abstract class LibraryAbstractBook {
  String get isbn13;

  String get title;

  String get cover;

  String? author;
  String? pubDate;
  String? publisher;
  String? description;
  int? sequence;
  bool? lendStatus;
  int? reservationCount;
}
