import 'package:easy_gpt_chat/app/core/configure_dependencies.dart';
import 'package:easy_gpt_chat/app/core/routes.dart';
import 'package:easy_gpt_chat/data/loca_data_source/hive_local_data_source.dart';
import 'package:easy_gpt_chat/data/remote_data_source/auth_remote_data_source.dart';
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart';
import 'package:easy_gpt_chat/features/auth/cubit/auth_cubit.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (
            context,
          ) =>
              getIt()..start(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => getIt(),
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
        routerConfig: router(
          AuthCubit(
            AuthRepository(
              HiveLocalDataSource(),
              AuthRemoteDataSource(),
            ),
          ),
        ),
      ),
    );
  }
}
