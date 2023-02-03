// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:easy_gpt_chat/data/loca_data_source/api_key_local_data_source.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domain/repositories/api_key_repository.dart';
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart';
import 'package:easy_gpt_chat/features/chat/chat_view.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations;
    return BlocProvider(
      create: (context) => ChatCubit(
        ChatGptRepository(
          ChatGptRemoteDataSource(),
        ),
        ApiKeyRepository(
          ApiKeyLocalDataSource(),
        ),
      )..start(),
      child: MaterialApp(
        title: 'EasyGPTchat',
        localizationsDelegates: [
          appLocalizations.delegate,
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
        home: const ChatView(),
      ),
    );
  }
}
