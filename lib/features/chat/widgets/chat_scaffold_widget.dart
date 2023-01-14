import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domains/models/message_model.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ChatScaffoldWidget extends StatelessWidget {
  const ChatScaffoldWidget({
    Key? key,
    required this.messages,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final List<MessageModel> messages;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'EasyGPT Chat',
            ),
          ),
          body: Column(
            children: [
              Flexible(
                child: ListView(
                  reverse: true,
                  children: [
                    for (final message in messages)
                      message.sender == 'user'
                          ? UserChatMessage(message: message)
                          : BotChatMessage(message: message),
                  ],
                ),
              ),
              LoadingContainerWidget(
                status: state.status,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          onSubmitted: (value) {
                            context.read<ChatCubit>().sendMessage(
                                  message: value,
                                  sender: 'user',
                                );
                            _textEditingController.clear();
                          },
                          controller: _textEditingController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Send a message'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ChatCubit>().sendMessage(
                                message: _textEditingController.text,
                                sender: 'user',
                              );
                          _textEditingController.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoadingContainerWidget extends StatelessWidget {
  const LoadingContainerWidget({
    Key? key,
    required this.status,
  }) : super(key: key);
  final Status status;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status == Status.loading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(80),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: JumpingDotsProgressIndicator(
                      dotSpacing: 2,
                      milliseconds: 300,
                      numberOfDots: 4,
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                backgroundImage: AssetImage('assets/images/computer.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserChatMessage extends StatelessWidget {
  const UserChatMessage({
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
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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

class BotChatMessage extends StatelessWidget {
  const BotChatMessage({
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(80),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
              backgroundColor: Colors.green,
              backgroundImage: AssetImage('assets/images/computer.png'),
            ),
          ),
        ],
      ),
    );
  }
}
