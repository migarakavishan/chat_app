import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../models/user_model.dart';

class ChatController {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  final firestore = FirebaseFirestore.instance;

  Stream<UserModel> listenToUser(String uid) {
    return users.doc(uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }

  CollectionReference msgCollection =
      FirebaseFirestore.instance.collection('Messages');

  CollectionReference conCollection =
      FirebaseFirestore.instance.collection('Conversation');

  Future<void> sendMessage(ConversationModel senderConModel,
      ConversationModel recieverConModel, MessageModel messageModel) async {
    String messageID = msgCollection.doc().id;
    messageModel.id = messageID;

    await msgCollection
        .doc(recieverConModel.user.uid)
        .collection(senderConModel.user.uid)
        .doc(messageID)
        .set(messageModel.toJson())
        .then((value) {
      Logger().f('Added Message To ${recieverConModel.user.name}');
    });

    await msgCollection
        .doc(senderConModel.user.uid)
        .collection(recieverConModel.user.uid)
        .doc(messageID)
        .set(messageModel.toJson())
        .then((value) {
      Logger().f('Added Message To ${senderConModel.user.name}');
    });

    await conCollection
        .doc(recieverConModel.user.uid)
        .collection('List')
        .doc(senderConModel.user.uid)
        .set(senderConModel.toJson())
        .then((value) {
      Logger().f('Added Conversation To ${recieverConModel.user.name}');
    });

    await conCollection
        .doc(senderConModel.user.uid)
        .collection('List')
        .doc(recieverConModel.user.uid)
        .set(recieverConModel.toJson())
        .then((value) {
      Logger().f('Added Conversation To ${senderConModel.user.name}');
    });
  }

  Stream<List<ConversationModel>> getConversations(String uid) {
    List<ConversationModel> list = [];
    return conCollection
        .doc(uid)
        .collection('List')
        .orderBy('lastTime', descending: true)
        .snapshots()
        .map((event) {
      list.clear();
      for (var element in event.docs) {
        ConversationModel conModel = ConversationModel.fromJson(element.data());
        list.add(conModel);
      }
      return list;
    });
  }

  Stream<List<MessageModel>> getMessages(String myUid, String uid) {
    List<MessageModel> list = [];
    return msgCollection
        .doc(myUid)
        .collection(uid)
        .orderBy('time', descending: true)
        .snapshots()
        .map((event) {
      list.clear();
      for (var element in event.docs) {
        MessageModel msgModel = MessageModel.fromJson(element.data());
        list.add(msgModel);
      }
      return list;
    });
  }
}
