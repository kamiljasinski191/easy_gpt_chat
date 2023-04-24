import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/app/dialogs/ad_revard_request_dialog.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:easy_gpt_chat/features/chat/widgets/bot_message_bubble.dart';
import 'package:easy_gpt_chat/features/chat/widgets/error_message_bubble.dart';
import 'package:easy_gpt_chat/features/chat/widgets/loading_bubble.dart';
import 'package:easy_gpt_chat/features/chat/widgets/popup_menu_widget.dart';
import 'package:easy_gpt_chat/features/chat/widgets/user_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const AdRewardRequestDialog(),
                          );
                        },
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 206, 26, 26),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(
                                'assets/images/tokens_red.svg',
                                width: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Free Tokens : ',
                              ),
                              Text(
                                authState.currentUser!.tokens.freeTokens
                                    .toString(),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.add,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Flexible(
                    child: ListView(
                      reverse: true,
                      children: [
                        LoadingBubble(
                          status: chatState.status,
                        ),
                        for (final message in messages) ...[
                          if (message.sender == 'user') ...[
                            UserMessageBubble(
                              message: message,
                            ),
                          ] else if (message.sender == 'bot') ...[
                            BotMessageBubble(
                              message: message,
                            ),
                          ] else if (message.sender == 'error') ...[
                            ErrorMessageBubble(
                              message: message,
                            ),
                          ]
                        ],
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
                              onSubmitted: chatState.status == Status.succes
                                  ? (value) {
                                      context.read<ChatCubit>().sendMessage(
                                          message: value,
                                          sender: 'user',
                                          textFieldCleaner: () {
                                            _textEditingController.clear();
                                          });

                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    }
                                  : null,
                              controller: _textEditingController,
                              decoration: InputDecoration.collapsed(
                                hintText:
                                    AppLocalizations.of(context)!.sendMessage,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: chatState.status == Status.succes
                                ? () {
                                    context.read<ChatCubit>().sendMessage(
                                        message: _textEditingController.text,
                                        sender: 'user',
                                        textFieldCleaner: () {
                                          _textEditingController.clear();
                                        });

                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                : null,
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
