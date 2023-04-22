import 'package:easy_gpt_chat/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/features/auth/auth_page.dart';
import 'package:easy_gpt_chat/features/chat/chat_page.dart';
import 'package:easy_gpt_chat/features/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootPage(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final authState = context.watch<AuthCubit>().state;
    if (authState.currentUser == null) {
      return '/auth';
    } else {
      return '/chat';
    }
  },
);
