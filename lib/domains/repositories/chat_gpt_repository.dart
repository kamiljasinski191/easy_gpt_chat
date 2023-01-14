import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_dource.dart';
import 'package:easy_gpt_chat/domains/models/message_model.dart';

class ChatGptRepository {
  ChatGptRepository(this.chatGptRemoteDataSource);
  ChatGPT? chatGPT;
  final ChatGptRemoteDataSource chatGptRemoteDataSource;

  Stream<MessageModel> streamConverted({required String text}) {
    return chatGptRemoteDataSource.chatStream(text: text).map((response) =>
        MessageModel(message: response.choices[0].text, sender: 'bot'));
  }
}
