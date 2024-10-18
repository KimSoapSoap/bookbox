import 'package:bookbox/core/utils/date_format.dart';

class Lend {
  int? lendId;
  String? lendDate;
  String returnDate;
  bool? returnStatus;

  String isbn13;
  String title;
  String cover;

  Lend({
    this.lendId,
    this.lendDate,
    required this.returnDate,
    this.returnStatus,
    required this.isbn13,
    required this.title,
    required this.cover,
  });

  Lend.fromMap(map)
      : this.lendId = map['lendId'],
        this.lendDate = DateUtil.format(map['lendDate']),
        this.returnDate = DateUtil.format(map['returnDate']),
        this.returnStatus = map['returnStatus'],
        this.isbn13 = map['isbn13'],
        this.title = map['title'],
        this.cover = map['cover'];
}
