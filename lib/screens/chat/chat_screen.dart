import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/header.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.user});
  final UserModel? user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          StreamBuilder(
              stream:
                  Provider.of<ChatProvider>(context).startListenToUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return ChatHeader(user: null, userModel: widget.user);
                }
                if (snapshot.hasError) {
                  return ChatHeader(user: null, userModel: widget.user);
                }
                UserModel? user = snapshot.data;
                return ChatHeader(
                  user: user,
                  userModel: widget.user,
                );
              }),
          const Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 20, left: 20),
                        child: Align(
                          alignment: index.isEven
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "14:25",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      BubbleSpecialThree(
                        text: 'Please try and give some feedback on it!',
                        color: index.isEven
                            ? const Color(0xFF1B97F3)
                            : Colors.grey.shade600,
                        isSender: index.isEven,
                        tail: true,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            height: 70,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        controller:
                            Provider.of<ChatProvider>(context, listen: false)
                                .msgController,
                        maxLines: 2,
                        minLines: 1,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Message"),
                      )),
                )),
                IconButton(
                    onPressed: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .startSendMessage(context);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
