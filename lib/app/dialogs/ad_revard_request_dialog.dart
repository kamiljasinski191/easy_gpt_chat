import 'package:easy_gpt_chat/app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdRewardRequestDialog extends StatelessWidget {
  const AdRewardRequestDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.adReward,
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppLocalizations.of(context)!.watchAd,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<AuthCubit>().showAdRewarded();
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
