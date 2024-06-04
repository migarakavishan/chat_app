import 'package:cloud_firestore/cloud_firestore.dart';

class UsersController {
  final users = FirebaseFirestore.instance.collection("Users");

  Stream<QuerySnapshot> getAllUsers() {
    return users.snapshots();
  }
}
