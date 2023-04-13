// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:easy_gpt_chat/app/core/configure_dependencies.dart';
import 'package:easy_gpt_chat/app/core/routes.dart';
import 'package:easy_gpt_chat/data/loca_data_source/hive_local_data_source.dart';
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart';
import 'package:easy_gpt_chat/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/features/chat/chat_page.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatCubit>(
          create: (context) => getIt()..start(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            AuthRepository(
              HiveLocalDataSource(),
            ),
          )..start(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'EasyGPTchat',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('pl'), // Polish
        ],
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          primarySwatch: Colors.green,
        ),
        routerConfig: router,
      ),
    );
  }
}
