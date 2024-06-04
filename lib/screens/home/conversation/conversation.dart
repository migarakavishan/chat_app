import 'package:chat_app/screens/home/users/users.dart';
import 'package:chat_app/utils/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import 'widgets/conversation_list.dart';
import 'widgets/header.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [Header(), ConversationList()],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomNavigation.nextPage(context, const UsersScreen());
        },
        child: const Icon(Icons.people),
      ),
    );
  }
}
