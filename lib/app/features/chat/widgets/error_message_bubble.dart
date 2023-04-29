import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:flutter/material.dart';

class ErrorMessageBubble extends StatelessWidget {
  const ErrorMessageBubble({
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
              backgroundColor: Color(0xFFC2060D),
              backgroundImage: AssetImage(
                'assets/images/error.png',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0x80C2060D),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: SelectableText(
                    message.message,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFFC2060D),
              backgroundImage: AssetImage('assets/images/error.png'),
            ),
          ),
        ],
      ),
    );
  }
}
