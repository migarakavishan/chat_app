import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/screens/auth/sign_in_page.dart';
import 'package:chat_app/screens/home/conversation/conversation.dart';
import 'package:chat_app/utils/navigation/custom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  User? _user;
  User? get user => _user;

  Future<void> listenToAuthState(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        CustomNavigation.nextPage(context, const SignInPage());
      } else {
        Logger().f('User is signed in!');
        _user = user;
        notifyListeners();
        CustomNavigation.nextPage(context, const ConversationScreen());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    final credetial = await authController.signInWithGoogle();

    if (credetial != null) {
      Logger().f(credetial.user!.email);
    }
  }
}
