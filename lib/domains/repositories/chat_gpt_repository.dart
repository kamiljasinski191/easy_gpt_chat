import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domains/models/message_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ChatGptRepository {
  ChatGptRepository(this.chatGptRemoteDataSource);
  ChatGPT? chatGPT;
  final ChatGptRemoteDataSource chatGptRemoteDataSource;

  Stream<MessageModel> chatStreamConverted({
    required String text,
    required String token,
  }) {
    return chatGptRemoteDataSource.chatStream(text: text, token: token).map(
      (response) {
        return MessageModel(
          message: response.choices[0].text,
          sender: 'bot',
        );
      },
    );
  }

  Future<bool> hasConnection() async {
    final hasConnection = await InternetConnectionChecker().hasConnection;
    return hasConnection;
  }
}
