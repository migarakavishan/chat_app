
import 'package:flutter/material.dart';

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
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                  "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}