import 'package:easy_gpt_chat/app/dialogs/about_chat_dialog.dart';
import 'package:easy_gpt_chat/app/dialogs/log_out_dialog.dart';
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
                    builder: (context) => const AboutChatDialog(),
                  );
                },
                child: Text(AppLocalizations.of(context)!.aboutApp),
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
                    builder: (context) => const LogOutDialog(),
                  );
                },
                child: Text(AppLocalizations.of(context)!.logOut),
              ),
            ),
          ),
        ];
      },
    );
  }
}
