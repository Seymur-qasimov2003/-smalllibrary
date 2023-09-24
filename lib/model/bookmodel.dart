import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String id;
  String bookName;
  String authorName;
  Timestamp publishDate;

  BookModel({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.publishDate,
  });

  ///objeden map e çevirme
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookName': bookName,
      'authorName': authorName,
      'publishDate': publishDate,
    };

    ///map den objeye çevirme
  }

  ///map den objeye çevirme
  factory BookModel.fromMap(Map map) {
    return BookModel(
      id: map['id'],
      bookName: map['bookName'],
      authorName: map['authorName'],
      publishDate: map['publishDate'],
    );
  }
}
