// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kitabxana/model/bookmodel.dart';
//
// class BorrowPage extends ConsumerStatefulWidget {
//   BookModel book;
//   BorrowPage({Key? key, required this.book}) : super(key: key);
//
//   @override
//   ConsumerState createState() => _ArchivePageState();
// }
//
// class _ArchivePageState extends ConsumerState<BorrowPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.book.bookName),
//         centerTitle: true,
//         elevation: 3,
//       ),
//       body: ListView.builder(
//           shrinkWrap: true,
//           itemCount: widget.book.borrows.length,
//           itemBuilder: (context, index) {
//             return Card(
//               child: ListTile(
//                 title: Text(widget.book.borrows[index].name),
//                 subtitle: Text('${widget.book.borrows[index].date1}'),
//                 trailing: Text('${widget.book.borrows[index].date2}'),
//               ),
//             );
//           }),
//     );
//   }
// }
