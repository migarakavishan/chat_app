import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/utils/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationList extends StatelessWidget {
  const ConversationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: Provider.of<ChatProvider>(context, listen: false)
              .startFetchConversation(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {}

            List<ConversationModel> conversations = snapshot.data!;
            return conversations.isNotEmpty
                ? ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Logger().f(conversations[index].user.toJson());
                            Provider.of<ChatProvider>(context, listen: false)
                                .setUser(conversations[index].user);
                            CustomNavigation.nextPage(
                                context,
                                ChatScreen(
                                  user: conversations[index].user,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(
                                conversations[index].user.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                conversations[index].lastMessage,
                                style: TextStyle(color: Colors.grey.shade800),
                              ),
                              leading: CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                    conversations[index].user.image),
                              ),
                              trailing: Text(timeago
                                  .format(conversations[index].lastTime)),
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      "No Conversations",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
          }),
    );
  }
}
