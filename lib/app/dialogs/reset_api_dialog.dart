import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetApiDialog extends StatelessWidget {
  const ResetApiDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.resetApiKey,
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppLocalizations.of(context)!.areYouSure,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<ChatCubit>().deleteChatApiKey();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.yes),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
    );
  }
}
