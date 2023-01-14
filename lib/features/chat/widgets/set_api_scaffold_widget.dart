import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetApiKeyScaffoldWidget extends StatelessWidget {
  const SetApiKeyScaffoldWidget({
    Key? key,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EasyGPT Chat',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    autofocus: true,
                    onSubmitted: (value) {
                      context.read<ChatCubit>().setChatApiKey(apiKey: value);
                      _textEditingController.clear();
                    },
                    controller: _textEditingController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Set your ApiKey'),
                  )),
                  IconButton(
                    onPressed: () {
                      context
                          .read<ChatCubit>()
                          .setChatApiKey(apiKey: _textEditingController.text);
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
  }
}
