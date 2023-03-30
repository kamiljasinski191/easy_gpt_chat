
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:easy_gpt_chat/features/chat/widgets/chat_scaffold_widget.dart';
import 'package:easy_gpt_chat/features/chat/widgets/error_scaffold_widget.dart';
import 'package:easy_gpt_chat/features/chat/widgets/initial_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
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
            return const InitialScaffoldWidget();
          case Status.error:
            return ErrorScaffoldWidget(
              textEditingController: _textEditingController,
            );
          default:
            return ChatScaffoldWidget(
              messages: messages,
              textEditingController: _textEditingController,
             
            );
        }
      },
    );
  }
}
