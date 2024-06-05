import 'package:chat_app/controllers/users_controller.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/navigation/custom_navigation.dart';
import '../../chat/chat_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const BackButton(),
                Text(
                  "Contacts",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 26,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: UsersController().getAllUsers(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      List<UserModel> uList = [];

                      for (var user in snapshot.data!.docs) {
                        UserModel u = UserModel.fromJson(
                            user.data() as Map<String, dynamic>);
                        uList.add(u);
                      }

                      return ListView.builder(
                          itemCount: uList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .setUser(uList[index]);
                                  CustomNavigation.nextPage(
                                      context,
                                      ChatScreen(
                                        user: uList[index],
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    title: Text(
                                      uList[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      uList[index].isOnline
                                          ? "Online"
                                          : timeago.format(DateTime.parse(
                                              uList[index].lastSeen)),
                                      style: TextStyle(
                                          color: Colors.grey.shade800),
                                    ),
                                    leading: CircleAvatar(
                                      radius: 16,
                                      backgroundImage:
                                          NetworkImage(uList[index].image),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }))
          ],
        ),
      )),
    );
  }
}
