import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class ChatController {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  Stream<UserModel> listenToUser(String uid) {
    return users.doc(uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }
}
