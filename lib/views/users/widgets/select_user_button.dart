import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/models/users/demo_users.dart';

class SelectUserButton extends StatelessWidget {
  const SelectUserButton({
    required this.user,
    required this.onPressed,
    super.key,
  });

  final DemoUser user;
  final ValueChanged<DemoUser> onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () => onPressed(user),
      child: Row(
        children: [
          Avatar.large(url: user.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.name, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    ),
  );
}
