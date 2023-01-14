import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoConnectionScaffoldWidget extends StatelessWidget {
  const NoConnectionScaffoldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EasyGPT Chat',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/white_no_wifi_icon.png'),
            ),
            const Text(
              'No internet connection.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              ' Check your connection and try again.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ChatCubit>().start();
              },
              child: const Text(
                'Reload',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
