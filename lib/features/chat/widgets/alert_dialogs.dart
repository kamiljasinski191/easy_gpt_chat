import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAboutAppDialog(
  BuildContext context,
) {
  return showDialog(

    context: context,
    
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'EasyGPT Chat',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '''EasyGPT Chat is a simple application that uses the official OpenAI API.
Unfortunately, it is just a demo, so the chat has limitations.
For example, it does not know the current date.''',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> showResetApiKeyDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        
        title: const Text(
          'Reset ApiKey',
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Are you sure you want to reset your API key?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ChatCubit>().deleteChatApiKey();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No!'),
          ),
        ],
      );
    },
  );
}
