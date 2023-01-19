import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dio/dio.dart';

class ChatGptRemoteDataSource {
  ChatGptRemoteDataSource();

  Stream chatStream({
    required String text,
    required String token,
  }) {
    final request = CompleteReq(
      prompt: text,
      model: kTranslateModelV3,
      max_tokens: 500,
    );

    final openAI = ChatGPT.instance.builder(
      token,
      baseOption: HttpSetup(
        connectTimeout: 20000,
        receiveTimeout: 20000,
      ),
    );
    try {
      final myStream = openAI.onCompleteText(request: request).asStream();
      return myStream;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<void> setToken({
    required String token,
  }) async {
    final openAI = ChatGPT.instance.builder(
      token,
      baseOption: HttpSetup(
        connectTimeout: 20000,
        receiveTimeout: 20000,
      ),
    );
    return openAI.setToken(token);
  }
}
