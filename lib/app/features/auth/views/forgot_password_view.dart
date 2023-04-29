import 'package:easy_gpt_chat/app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.resetPassword,
                style: const TextStyle(fontSize: 32),
              ),
              Text(
                AppLocalizations.of(context)!.provideEmail,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: emailController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          35,
                        ),
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.e_Mail,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthCubit>()
                        .resetPassword(email: emailController.text);
                    emailController.clear();
                    context.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  context.go('/auth');
                },
                child: Text(
                  AppLocalizations.of(context)!.backToLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
