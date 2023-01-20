import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorScaffoldWidget extends StatelessWidget {
  const ErrorScaffoldWidget({
    Key? key,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);
  final TextEditingController _textEditingController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.errorMessage == 'noApiKey') {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'EasyGPT Chat',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("It's demo of ChatGPT from official API,"),
                    const Text("and u need official ApiKey from openAi.com."),
                    const Text("Please visit, to get your Key:"),
                    TextButton(
                      onPressed: () {
                        context.read<ChatCubit>().launchOpenAiUrl();
                      },
                      child: const Text(
                          'https://beta.openai.com/account/api-keys'),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          autofocus: true,
                          onSubmitted: (value) {
                            context
                                .read<ChatCubit>()
                                .setChatApiKey(apiKey: value);
                            _textEditingController.clear();
                          },
                          controller: _textEditingController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Set your ApiKey'),
                        )),
                        IconButton(
                          onPressed: () {
                            context.read<ChatCubit>().setChatApiKey(
                                apiKey: _textEditingController.text);
                            _textEditingController.clear();
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.errorMessage == 'noInternet') {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'EasyGPT Chat',
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/white_no_wifi_icon.png'),
                    ),
                    const Text(
                      'No internet connection.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      ' Check your connection and try again.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChatCubit>().start();
                      },
                      child: const Text(
                        'Reload',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.errorCode == 'invalid_api_key') {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'EasyGPT Chat',
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'An error has ocured. Reload app and try again',
                    ),
                    Text(
                      state.errorMessage,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChatCubit>().deleteChatApiKey();
                      },
                      child: const Text(
                        'Set New ApiKey',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'EasyGPT Chat',
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'An error has ocured. Reload app and try again',
                    ),
                    Text(
                      state.errorMessage,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChatCubit>().start();
                      },
                      child: const Text(
                        'Reload',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
