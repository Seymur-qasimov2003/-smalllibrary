import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/addbookviewmodel.dart';
import '../viewmodel/booksviewmodel.dart';
import '../viewmodel/updatebookviewmodel.dart';

var booksviewmodelprovider = ChangeNotifierProvider((ref) => BooksViewModel());
var addbookviewmodelprovider =
    ChangeNotifierProvider((ref) => AddBookViewModel());
var updatebookviewmodelprovider =
    ChangeNotifierProvider((ref) => UpdateBookViewModel());
