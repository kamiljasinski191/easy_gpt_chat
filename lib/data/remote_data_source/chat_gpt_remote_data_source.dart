import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:easy_gpt_chat/env/env.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatGptRemoteDataSource {
  ChatGptRemoteDataSource();

  Stream chatStream({
    required String text,
  }) {
    final request = CompleteReq(
      messages: [
        {"role": "user", "content": text}
      ],
      model: kTranslateModelv35,
      max_tokens: 700,
      temperature: .4,
    );

    final openAI = ChatGPT.instance.builder(
      Env.openAiKey,
      baseOption: HttpSetup(
        connectTimeout: 5000,
        receiveTimeout: 50000,
      ),
    );
    final myStream = openAI.onCompleteText(request: request).asStream();
    return myStream;
    // try {

    // } on DioError catch (_) {
    //   rethrow;
    // }
  }

  Future<void> setToken() async {
    final openAI = ChatGPT.instance.builder(
      Env.openAiKey,
      baseOption: HttpSetup(
        connectTimeout: 20000,
        receiveTimeout: 50000,
      ),
    );
    return openAI.setToken(Env.openAiKey);
  }

 
}
