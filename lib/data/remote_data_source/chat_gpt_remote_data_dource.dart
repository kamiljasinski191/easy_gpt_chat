import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class ChatGptRemoteDataSource {
  ChatGptRemoteDataSource(this.token);
  final String token;
  final openAI = ChatGPT.instance.builder(
      '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',
      baseOption: HttpSetup());

  Stream chatStream({required String text}) {
    final request =
        CompleteReq(prompt: text, model: kTranslateModelV3, max_tokens: 200);

    return openAI.onCompleteStream(request: request);
  }
}
