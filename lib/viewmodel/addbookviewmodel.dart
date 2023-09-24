import 'package:flutter/cupertino.dart';
import 'package:kitabxana/model/bookmodel.dart';
import 'package:kitabxana/services/calculator.dart';
import 'package:kitabxana/services/database.dart';

class AddBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String _refereancepath = 'books';
  Future<void> addnewbook(
      String bookName, String authorName, DateTime publishDate) async {
    BookModel newbook = BookModel(
      id: DateTime.now().toString(),
      bookName: bookName,
      authorName: authorName,
      publishDate: Calculator.gettimestampfromdatetime(publishDate),
    );
    await _database.addorupdate(_refereancepath, newbook.toMap());
  }
}
