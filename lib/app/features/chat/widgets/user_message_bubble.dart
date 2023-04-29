import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:flutter/material.dart';

class UserMessageBubble extends StatelessWidget {
  const UserMessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage:
                  AssetImage('assets/images/user_profile_avatar.png'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(80),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: SelectableText(
                    message.message,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
