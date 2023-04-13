import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:easy_gpt_chat/features/chat/views/chat_view.dart';
import 'package:easy_gpt_chat/features/chat/views/error_view.dart';
import 'package:easy_gpt_chat/features/chat/views/initial_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final messages = state.messages;
        final status = state.status;
        switch (status) {
          case Status.initial:
            return const InitialView();
          case Status.error:
            return ErrorView(
              textEditingController: _textEditingController,
            );
          default:
            return ChatView(
              messages: messages,
              textEditingController: _textEditingController,
            );
        }
      },
    );
  }
}
