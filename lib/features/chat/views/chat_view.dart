import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:easy_gpt_chat/features/chat/widgets/bot_message_bubble.dart';
import 'package:easy_gpt_chat/features/chat/widgets/loading_bubble.dart';
import 'package:easy_gpt_chat/features/chat/widgets/popup_menu_widget.dart';
import 'package:easy_gpt_chat/features/chat/widgets/user_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

class ChatView extends StatelessWidget {
  const ChatView({
    Key? key,
    required this.messages,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);
  final List<MessageModel> messages;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        BannerAd? bannerAd = authState.bannerAd;

        return BlocBuilder<ChatCubit, ChatState>(
          builder: (context, chatState) {
            return Scaffold(
              bottomNavigationBar: bannerAd != null && Platform.isAndroid
                  ? SizedBox(
                      height: bannerAd.size.height.toDouble(),
                      width: bannerAd.size.width.toDouble(),
                      child: AdWidget(
                        ad: bannerAd,
                      ),
                    )
                  : null,
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'EasyGPT Chat',
                ),
                actions: const [
                  PopupMenuWidget(),
                  SizedBox(
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
                              ? UserMessageBubble(message: message)
                              : BotMessageBubble(message: message),
                      ],
                    ),
                  ),
                  LoadingBubble(
                    status: chatState.status,
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
                                hintText:
                                    AppLocalizations.of(context)!.sendMessage,
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
      },
    );
  }
}
