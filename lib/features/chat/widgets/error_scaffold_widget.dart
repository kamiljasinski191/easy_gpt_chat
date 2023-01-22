import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    Text(AppLocalizations.of(context)!.itIsDemo),
                    Text(AppLocalizations.of(context)!.andYouNeed),
                    Text(AppLocalizations.of(context)!.pleaseVisit),
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
                          decoration: InputDecoration.collapsed(
                              hintText: AppLocalizations.of(context)!.setKey),
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
                    Text(
                      AppLocalizations.of(context)!.noInternet,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.checkInternet,
                      style: const TextStyle(
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
                      child: Text(
                        AppLocalizations.of(context)!.reload,
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
                    Text(
                      '${AppLocalizations.of(context)!.anError} ${AppLocalizations.of(context)!.apiKeyInvalid}',
                    ),
                    const SizedBox(
                      height: 20,
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
                      child: Text(
                        AppLocalizations.of(context)!.setNewKey,
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
                    Text(
                      '${AppLocalizations.of(context)!.anError} ${AppLocalizations.of(context)!.reloadAndTryAgain}',
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
                      child: Text(
                        AppLocalizations.of(context)!.reload,
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
