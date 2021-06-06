import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> createClient(Map userData, String userId) async {
    await FirebaseFirestore.instance
        .collection("Clientes")
        .doc(userId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getClient() async {
    return await FirebaseFirestore.instance.collection("Clientes").snapshots();
  }
}
