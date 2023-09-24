import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitabxana/services/calculator.dart';

import '../riverpodmanagement/riverpodmanagement.dart';

class AddBook extends ConsumerStatefulWidget {
  const AddBook({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AddBookState();
}

class _AddBookState extends ConsumerState<AddBook> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _authorcontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  var _selecteddate;
  @override
  void dispose() {
    _namecontroller.dispose();
    _authorcontroller.dispose();
    _datecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitab elave et'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namecontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.book),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Kitabin adi',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kitabin adi bos kecilemez';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _authorcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Kitabin yazarin adi',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'yazarin adi bos ola bilmez';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _datecontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.date_range),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Kitabin cixis tarixi',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'cixis tarixi bos ola bilmez';
                        } else {
                          return null;
                        }
                      },
                      onTap: () async {
                        _selecteddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );
                        _datecontroller.text =
                            Calculator.getstringfromdatetime(_selecteddate);
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          ref.watch(addbookviewmodelprovider).addnewbook(
                                _namecontroller.text,
                                _authorcontroller.text,
                                _selecteddate,
                              );
                          Navigator.pop(context);
                        }
                        // ref.read(booksviewmodelprovider).addbook(
                        //     _namecontroller.text,
                        //     _authorcontroller.text,
                        //     _datecontroller.text);
                      },
                      child: const Text('Kitabi elave et'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
