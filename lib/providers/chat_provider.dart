import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/providers/auth_provider.dart' as auth_provider;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/chat_controller.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class ChatProvider extends ChangeNotifier {
  UserModel? _me;
  UserModel? get me => _me;
  UserModel? _user;
  UserModel? get user => _user;
  final TextEditingController _msgController = TextEditingController();
  TextEditingController get msgController => _msgController;

  Stream<UserModel> startListenToUserData() {
    final stream = ChatController().listenToUser(_user!.uid);
    stream.listen((model) {
      _user = model;
      notifyListeners();
    });

    return stream;
  }

  void setUser(UserModel model) {
    _user = model;
    notifyListeners();
  }

  Future<void> startSendMessage(BuildContext context) async {
    if (_msgController.text.isNotEmpty) {
      User user =
          Provider.of<auth_provider.AuthProvider>(context, listen: false).user!;
      _me = UserModel(
          name: user.displayName!,
          image: user.photoURL!,
          isOnline: false,
          lastSeen: DateTime.now().toString(),
          uid: user.uid);

      MessageModel message = MessageModel(
          id: "",
          message: _msgController.text,
          uid: _me!.uid,
          time: DateTime.now());

      ConversationModel senderConModel = ConversationModel(
          lastMessage: _msgController.text,
          lastTime: DateTime.now(),
          user: _user!);

      ConversationModel recieverConModel = ConversationModel(
          lastMessage: _msgController.text,
          lastTime: DateTime.now(),
          user: _me!);
      ChatController()
          .sendMessage(senderConModel, recieverConModel, message)
          .then((value) {
        _msgController.clear();
        notifyListeners();
      });
    }
  }

  Stream<List<ConversationModel>> startFetchConversation(BuildContext context) {
    String uid = Provider.of<auth_provider.AuthProvider>(context, listen: false).user!.uid;
    return ChatController().getConversations(uid);
  }
}
