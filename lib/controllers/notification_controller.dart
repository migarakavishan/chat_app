import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class NotificationController {
  Future<void> updateToken() async {
    final users = FirebaseFirestore.instance.collection("Users");
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await users.doc(uid).update({'token': token}).then((value) {
      Logger().f(token);
    });
  }

  void handleForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().f('Got a message whilst in the foreground!');
      Logger().f('Message data: ${message.data}');

      if (message.notification != null) {
        Logger().f(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleBackgroundMsgClick(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMsgClick);
  }

  void _handleBackgroundMsgClick(RemoteMessage message) {
    if (message.data["type"] != null) {
      Logger().f(message.data["type"]);
    } else {
      Logger().e("Not Valid");
    }
  }
}
