import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/app/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/app/features/auth/views/auth_error_view.dart';
import 'package:easy_gpt_chat/app/features/auth/views/auth_loading_view.dart';
import 'package:easy_gpt_chat/app/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    switch (authState.status) {
      case Status.initial:
        return const AuthLoadingView();
      case Status.loading:
        return const AuthLoadingView();
      case Status.error:
        return const AuthErrorView();
      case Status.succes:
        if (authState.currentUser == null) {
          return const LoginView();
        } else {
          return const AuthLoadingView();
        }
    }
  }
}
