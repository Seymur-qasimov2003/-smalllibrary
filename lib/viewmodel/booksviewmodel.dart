import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/bookmodel.dart';
import '../services/database.dart';

class BooksViewModel extends ChangeNotifier {
  Database _database = Database();
  String _refereancepath = 'books';

  ///listeleme işlemi
  Stream<List<BookModel>> getbooklist() {
    ///Stream<QuerySnapshot> -----Stream<List<DocumentSnapshot>>----Stream<List<BookModel>>;
    const String refereancepath = 'books';
    Stream<List<DocumentSnapshot>> streamdocsnap = _database
        .getlistfromdatabase(refereancepath)
        .map((querysnap) => querysnap.docs);
    Stream<List<BookModel>> streamlistbook = streamdocsnap.map(
        (listofdocsnap) => listofdocsnap
            .map((docsnap) =>
                BookModel.fromMap(docsnap.data() as Map<String, dynamic>))
            .toList());

    return streamlistbook;
  }

  ///silme işlemi
  Future<void> deletebook(BookModel book) async {
    await _database.deletefromdatabase(_refereancepath, book.id);
  }

  ///ekleme ve guncelleme islemi

}
