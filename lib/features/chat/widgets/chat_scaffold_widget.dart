import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/app/dialogs/about_chat_dialog.dart';
import 'package:easy_gpt_chat/app/dialogs/reset_api_dialog.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

class ChatScaffoldWidget extends StatelessWidget {
  const ChatScaffoldWidget(
      {Key? key,
      required this.messages,
      required TextEditingController textEditingController,
      required this.ad})
      : _textEditingController = textEditingController,
        super(key: key);

  final List<MessageModel> messages;
  final TextEditingController _textEditingController;
  final BannerAd? ad;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: ad != null && Platform.isAndroid
              ? SizedBox(
                  height: ad!.size.height.toDouble(),
                  width: ad!.size.width.toDouble(),
                  child: AdWidget(
                    ad: ad!,
                  ),
                )
              : null,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'EasyGPT Chat',
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => const ResetApiDialog(),
                            );
                          },
                          child:
                              Text(AppLocalizations.of(context)!.resetApiKey),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => const AboutChatDialog(),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.aboutApp),
                        ),
                      ),
                    ),
                  ];
                },
              ),
              const SizedBox(
                width: 12,
              ),
            ],
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
                          onSubmitted: (value) {
                            context.read<ChatCubit>().sendMessage(
                                  message: value,
                                  sender: 'user',
                                );
                            _textEditingController.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: _textEditingController,
                          decoration: InputDecoration.collapsed(
                            hintText: AppLocalizations.of(context)!.sendMessage,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ChatCubit>().sendMessage(
                                message: _textEditingController.text,
                                sender: 'user',
                              );
                          _textEditingController.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
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
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(80),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: JumpingDotsProgressIndicator(
                      dotSpacing: 1.5,
                      milliseconds: 100,
                      numberOfDots: 5,
                      fontSize: 36,
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
