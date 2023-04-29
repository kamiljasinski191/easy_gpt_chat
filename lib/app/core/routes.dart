import 'package:easy_gpt_chat/app/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/app/features/auth/auth_page.dart';
import 'package:easy_gpt_chat/app/features/auth/views/forgot_password_view.dart';
import 'package:easy_gpt_chat/app/features/chat/chat_page.dart';
import 'package:easy_gpt_chat/app/features/root_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router(AuthCubit authCubit) {
  return GoRouter(
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
          routes: [
            GoRoute(
              path: 'forgotPassword',
              name: 'forgotPassword',
              builder: (context, state) => ForgotPasswordView(),
            ),
          ]),
    ],
  );
}
