import 'package:easy_gpt_chat/data/loca_data_source/api_key_local_data_source.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domains/repositories/api_key_repository.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
import 'package:easy_gpt_chat/features/chat/chat_view.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
