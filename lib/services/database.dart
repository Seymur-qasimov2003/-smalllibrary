import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///listeleme işlemi
  Stream<QuerySnapshot> getlistfromdatabase(String refereancepath) {
    return _firestore.collection(refereancepath).snapshots();
  }

  ///silme işlemi
  Future<void> deletefromdatabase(String refereancepath, String id) async {
    await _firestore.collection(refereancepath).doc(id).delete();
  }

  ///ekleme ve guncelleme islemi
  Future<void> addorupdate(
      String refereancepath, Map<String, dynamic> data) async {
    String id = data['id'];
    await _firestore.collection(refereancepath).doc(id).set(data);
  }
}
