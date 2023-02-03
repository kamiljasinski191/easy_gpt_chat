import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutChatDialog extends StatelessWidget {
  const AboutChatDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'EasyGPT Chat',
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppLocalizations.of(context)!.aboutAppContent,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.ok,
          ),
        ),
      ],
    );
  }
}
