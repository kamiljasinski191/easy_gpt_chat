import 'package:easy_gpt_chat/app/dialogs/about_chat_dialog.dart';
import 'package:easy_gpt_chat/app/dialogs/reset_api_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
                child: Text(AppLocalizations.of(context)!.resetApiKey),
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
    );
  }
}
