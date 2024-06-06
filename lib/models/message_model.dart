import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String uid;
  String message;
  DateTime time;
  String id;

  MessageModel(
      {required this.id,
      required this.message,
      required this.uid,
      required this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['id'],
        message: json['message'],
        uid: json['uid'],
        time: (json['time'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'uid': uid,
      'time': time
    };
  }
}
