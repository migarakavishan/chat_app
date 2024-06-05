import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/user_model.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader(
      {super.key,
      required this.user,
      
      required this.userModel});

  final UserModel? user;
  
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(user != null ? user!.image : userModel!.image),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user != null ? user!.name : userModel!.name,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              user !=null ? user!.isOnline
                  ? 'Online'
                  : timeago.format(DateTime.parse(user!.lastSeen)) : "",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            )
          ],
        )
      ],
    );
  }
}
