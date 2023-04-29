import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatGptRepository {
  ChatGptRepository(this.chatGptRemoteDataSource);
  ChatGPT? chatGPT;
  final ChatGptRemoteDataSource chatGptRemoteDataSource;

  Stream<MessageModel> chatStreamConverted({
    required String text,
  }) {
    return chatGptRemoteDataSource
        .chatStream(
      text: text,
    )
        .map(
      (response) {
        return MessageModel(
          message: response.choices[0].message['content'],
          sender: 'bot',
        );
      },
    );
  }

  Future<void> setToken() async {
    return chatGptRemoteDataSource.setToken();
  }
}
