import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/data/loca_data_source/api_key_local_data_source.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domains/repositories/api_key_repository.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
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
    return BlocProvider(
      create: (context) => ChatCubit(
        ChatGptRepository(
          ChatGptRemoteDataSource(),
        ),
        ApiKeyRepository(
          ApiKeyLocalDataSource(),
        ),
      )..start(),
      child: BlocBuilder<ChatCubit, ChatState>(
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
                  textEditingController: _textEditingController);
          }
        },
      ),
    );
  }
}
