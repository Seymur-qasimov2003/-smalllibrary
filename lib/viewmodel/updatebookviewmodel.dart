import 'package:flutter/cupertino.dart';

import '../model/bookmodel.dart';
import '../services/calculator.dart';
import '../services/database.dart';

class UpdateBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String _refereancepath = 'books';
  Future<void> updatebook(String bookName, String authorName,
      DateTime publishDate, BookModel book) async {
    BookModel newbook = BookModel(
      id: book.id,
      bookName: bookName,
      authorName: authorName,
      publishDate: Calculator.gettimestampfromdatetime(publishDate),
    );
    await _database.addorupdate(_refereancepath, newbook.toMap());
  }
}
