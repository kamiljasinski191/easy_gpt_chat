import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_dource.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
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
      create: (context) =>
          ChatCubit(ChatGptRepository(ChatGptRemoteDataSource('TOKEN'))),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          final messages = state.messages;
          final status = state.status;
          switch (status) {
            case Status.loading:
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'EasyGPT Chat',
                  ),
                ),
                body: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                )),
              );

            default:
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'EasyGPT Chat',
              ),
            ),
            body: Column(
              children: [
                Text(
                  'ConnectionStatus: ${state.status}',
                ),
                Flexible(
                  child: ListView(
                    reverse: true,
                    children: [
                      for (final message in messages)
                        message.sender == 'user'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          backgroundImage: AssetImage(
                                              'assets/images/user_profile_avatar.png')),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue.withAlpha(80),
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              message.message,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green.withAlpha(80),
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
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
                                          backgroundImage: AssetImage(
                                              'assets/images/user_profile_avatar.png')),
                                    ),
                                  ],
                                ),
                              ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          onSubmitted: (value) {
                            context
                                .read<ChatCubit>()
                                .sendMessage(message: value);
                            _textEditingController.clear();
                          },
                          controller: _textEditingController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Send a message'),
                        )),
                        IconButton(
                          onPressed: () {
                            context.read<ChatCubit>().sendMessage(
                                message: _textEditingController.text);
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
      ),
    );
  }
}
