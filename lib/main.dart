// ignore_for_file: depend_on_referenced_packages

import 'package:easy_gpt_chat/data/loca_data_source/api_key_local_data_source.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domains/repositories/api_key_repository.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
import 'package:easy_gpt_chat/features/chat/chat_view.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const RootPage();
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        home: const ChatView(),
      ),
    );
  }
}
