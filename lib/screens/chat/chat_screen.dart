import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
          Row(
            children: [
              const BackButton(),
              const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                    "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kamal Bandara",
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Last seen at 18:45",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  )
                ],
              )
            ],
          ),
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
          MessageBar(
            onSend: (_) => print(_),
            actions: [
              InkWell(
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
