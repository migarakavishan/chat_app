import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  UserModel? _me;
  UserModel? get me => _me;
  UserModel? _user;
  UserModel? get user => _user;

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
}
