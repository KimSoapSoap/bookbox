class Book {
  String? isbn13;
  String? title;
  String? cover;
  String? author;
  String? pubDate;
  String? publisher;
  String? description;
  String? categoryId;
  int? sequence;
  bool? lendStatus;
  int? reservationCount;

  Book(
      {this.isbn13,
      this.title,
      this.author,
      this.publisher,
      this.cover,
      this.categoryId,
      this.pubDate,
      this.description,
      this.sequence,
      this.lendStatus,
      this.reservationCount});

  //String returnDate;

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
        this.reservationCount = map['reservationCount'];
}
