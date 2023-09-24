import 'package:cloud_firestore/cloud_firestore.dart';

class BorrowModel {
  String name;
  String surname;
  Timestamp date1;
  Timestamp date2;
  String photourl;

  BorrowModel({
    required this.name,
    required this.surname,
    required this.date1,
    required this.date2,
    required this.photourl,
  });

  ///objeden map e çevirme
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'date1': date1,
      'date2': date2,
      'photourl': photourl,
    };
  }

  ///mapden objeye çevirme
  factory BorrowModel.fromMap(Map map) {
    return BorrowModel(
      name: map['name'],
      surname: map['surname'],
      date1: map['date1'],
      date2: map['date2'],
      photourl: map['photourl'],
    );
  }
}
