import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "My Chat",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Provider.of<AuthProvider>(context , listen: false).signOut();
              },
              child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      Provider.of<AuthProvider>(context).user!.photoURL!)),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
