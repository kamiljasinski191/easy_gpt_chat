import 'package:easy_gpt_chat/app/core/configure_dependencies.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/app/features/chat/cubit/chat_cubit.dart';
import 'package:easy_gpt_chat/app/features/chat/views/chat_view.dart';
import 'package:easy_gpt_chat/app/features/chat/views/chat_error_view.dart';
import 'package:easy_gpt_chat/app/features/chat/views/chat_initial_view.dart';
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
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (context) => getIt()..start(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          final messages = state.messages;
          final status = state.status;
          switch (status) {
            case Status.initial:
              return const ChatInitialView();
            case Status.error:
              return const ChatErrorView();
            default:
              return ChatView(
                messages: messages,
                textEditingController: _textEditingController,
              );
          }
        },
      ),
    );
  }
}
