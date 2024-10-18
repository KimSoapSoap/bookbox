class Book {
  String isbn13;
  String title;
  String cover;
  String? author;
  String? pubDate;
  String? publisher;
  String? description;
  String? categoryId;
  int? sequence;
  bool? lendStatus;
  bool? reservationStatus;
  int? lendCount;
  int? reservationCount;
  int? likeCount;

  Book(
      {required this.isbn13,
      required this.title,
      required this.cover,
      this.author,
      this.publisher,
      this.categoryId,
      this.pubDate,
      this.description,
      this.sequence,
      this.lendStatus,
      this.reservationStatus,
      this.lendCount,
      this.reservationCount,
      this.likeCount});

  Book.fromMap(map)
      : this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.author = map['author'],
        this.publisher = map['publisher'],
        this.categoryId = map['categoryId'],
        this.pubDate = map['pubDate'],
        this.cover = map['cover'],
        this.description = map['description'],
        this.sequence = map['sequence'],
        this.lendStatus = map['lendStatus'],
        this.reservationStatus = map['reservationStatus'],
        this.lendCount = map['lendCount'],
        this.reservationCount = map['reservationCount'],
        this.likeCount = map['likeCount'];
}
