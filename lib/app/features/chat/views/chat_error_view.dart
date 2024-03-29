import 'package:easy_gpt_chat/app/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatErrorView extends StatelessWidget {
  const ChatErrorView({
    Key? key,
  }) : super(key: key);
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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.anError} ${AppLocalizations.of(context)!.reloadAndTryAgain}',
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
      },
    );
  }
}
