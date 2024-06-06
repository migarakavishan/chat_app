import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  UserModel user;

  String lastMessage;
  DateTime lastTime;

  ConversationModel(
      {required this.lastMessage, required this.lastTime, required this.user});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      lastMessage: json['lastMessage'],
      lastTime: (json['lastTime'] as Timestamp).toDate(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastMessage': lastMessage,
      'lastTime': lastTime,
      'user': user.toJson()
    };
  }
}
