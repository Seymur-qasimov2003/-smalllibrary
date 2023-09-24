import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kitabxana/model/bookmodel.dart';
import 'package:kitabxana/views/updatebook.dart';

import '../riverpodmanagement/riverpodmanagement.dart';
import 'addbook.dart';

class BooksPage extends ConsumerStatefulWidget {
  const BooksPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CrudPageState();
}

class _CrudPageState extends ConsumerState<BooksPage> {
  TextEditingController _searchcontroller = TextEditingController();
  bool _issearching = false;
  bool _isloading = false;
  List<BookModel> filteredbooks = [];
  List<BookModel> docs = [];

  @override
  Widget build(BuildContext context) {
    // final CollectionReference kitabxanareferance =
    //     _firestore.collection('kitabxana');
    // final DocumentReference hobbitreferance = kitabxanareferance.doc('Hobbit');

    return Scaffold(
      appBar: AppBar(
        title: _issearching
            ? TextField(
                scrollPhysics: const BouncingScrollPhysics(),
                textDirection: TextDirection.ltr, // default
                autocorrect: true,
                keyboardAppearance: Brightness.dark,
                cursorColor: Colors.white,
                cursorRadius: Radius.circular(10),
                scrollController: ScrollController(
                  keepScrollOffset: true,
                  debugLabel: 'scrollcontroller',
                  initialScrollOffset: 100,
                ),
                textAlign: TextAlign.center,
                clipBehavior: Clip.antiAlias,
                controller: _searchcontroller,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  hintTextDirection: TextDirection.ltr,
                ),
                onChanged: (value) {
                  setState(() {
                    filteredbooks = docs
                        .where((element) =>
                            element.bookName.toLowerCase().contains(value))
                        .toList();
                  });
                },
              )
            : const Text('KitablarListesi'),
        centerTitle: true,
        actions: [
          _issearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this._issearching = false;
                      filteredbooks = [];
                      _searchcontroller.clear();
                    });
                  },
                  icon: const Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this._issearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchcontroller,
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      _issearching = true;
                      filteredbooks = docs
                          .where((element) =>
                              element.bookName
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.authorName
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .toList();
                    } else {
                      _issearching = false;
                    }
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.clear),
                  hintText: 'Kitap ismi veya yazar ismi ile arama yapin',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            /// Text('kitabxana:${kitabxanareferance.parameters}'),
            // ElevatedButton(
            //   onPressed: () async {
            //     DocumentSnapshot datadoc = await hobbitreferance.get();
            //     Map<String, dynamic> data =
            //         datadoc.data() as Map<String, dynamic>;
            //     print('data:${data['yazar']}');
            //     var kitabxanareficerik = await kitabxanareferance.get();
            //     var docs = kitabxanareficerik.docs;
            //     for (var doc in docs) {
            //       print('doc:${doc.data()}');
            //     }
            //     // print('${docs.length}');
            //     // for (var doc in docs) {
            //     //   print('${doc.data()}');
            //     // }
            //   },
            //   child: const Text('getir'),
            // ),
            StreamBuilder<List<BookModel>>(
              stream: ref.watch(booksviewmodelprovider).getbooklist(),
              builder: (context, asyncsnapshot) {
                if (asyncsnapshot.hasError) {
                  return CircularProgressIndicator();
                } else {
                  if (asyncsnapshot.hasData) {
                    docs = asyncsnapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          _issearching ? filteredbooks.length : docs.length,
                      itemBuilder: (context, index) {
                        var doc =
                            _issearching ? filteredbooks[index] : docs[index];
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                  onPressed: (BuildContext context) {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => BorrowPage(
                                    //             // kitabxana kitablarin listesinden kitabi secip odunc verme sayfasina gecis yapar
                                    //             book: doc)));
                                  },
                                  label: 'Kayitlara bax',
                                  backgroundColor: Colors.green,
                                  icon: Icons.person),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                flex: 1,

                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Sil',
                                onPressed: (BuildContext context) {
                                  ref
                                      .read(booksviewmodelprovider)
                                      .deletebook(doc);
                                },
                              ),
                              SlidableAction(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Guncelle',
                                onPressed: (BuildContext context) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateBook(
                                                bookmodel: doc,
                                              )));
                                },
                              ),
                            ],
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text('${doc.bookName}'),
                              subtitle: Text('${doc.authorName}'),
                              trailing: Text(' sola  kaydir'),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        focusElevation: 100,
        hoverElevation: 100,
        mouseCursor: SystemMouseCursors.allScroll,
        splashColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.black,
        disabledElevation: 100,
        hoverColor: Colors.green,
        heroTag: 'addbook',
        highlightElevation: 100,
        autofocus: true,
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddBook();
          }));

          ///elave etmek
          /// await kitabxanareferance.add(addedbook);
          /// set  edende eger bele bir doc varsa onu update edir yoxdusa yaradir
          /// await kitabxanareferance.doc('Leyli ve Mecnun').set(addedbook);
          /// update edende her hansi bir alani deyismek olur
          // await kitabxanareferance
          //     .doc('Leyli ve Mecnun')
          //     .update({'yazar': 'Nizami Gencevi'});
        },
        icon: const Icon(Icons.add),
        label: const Text('Kitab elave et'),
      ),
    );
  }

  AppBar buildAppBar1() {
    return AppBar(
      title: const Text('Kitablarin Listesi'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _issearching = !_issearching;
            });
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget TextFieldd() {
    return TextField(
      decoration: InputDecoration(),
    );
  }
}
