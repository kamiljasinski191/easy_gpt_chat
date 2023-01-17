import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domains/models/message_model.dart';
import 'package:easy_gpt_chat/domains/repositories/api_key_repository.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatGptRepository, this.apiKeyRepository)
      : super(const ChatState());

  final ChatGptRepository chatGptRepository;
  final ApiKeyRepository apiKeyRepository;

  StreamSubscription? streamSubscription;

  List<MessageModel> messages = [];

  Future<void> start() async {
    emit(
      state.copyWith(
        status: Status.initial,
      ),
    );
    bool hasConnection = await chatGptRepository.hasConnection();
    final apiKey = await apiKeyRepository.getSecuredApiKey();

    if (apiKey == null || apiKey.length < 10) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'noApiKey',
        ),
      );
    } else if (!hasConnection) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'noInternet',
        ),
      );
    } else {
      //Walkover to initialize token. And give nice welcome message.
      await sendMessage(
        message:
            'Welcome to EasyGPT chat. Please type your first question or problem.',
        sender: 'bot',
      );
      emit(
        state.copyWith(
          status: Status.loading,
          messages: messages,
        ),
      );
      emit(
        state.copyWith(
          status: Status.succes,
          messages: messages,
        ),
      );
    }
  }

  Future<void> setChatApiKey({
    required String apiKey,
  }) async {
    await apiKeyRepository.setSecuredApiKey(apiKey: apiKey);
    start();
  }

  Future<void> sendMessage({
    required String message,
    required String sender,
  }) async {
    emit(
      state.copyWith(
        status: Status.loading,
        messages: messages,
      ),
    );
    bool hasConnection = await chatGptRepository.hasConnection();
    final apiKey = await apiKeyRepository.getSecuredApiKey();
    if (apiKey == null || apiKey.length < 10) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'noApiKey',
        ),
      );
    } else if (!hasConnection) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'noInternet',
        ),
      );
    } else {
      final MessageModel requestMessage = MessageModel(
        message: message,
        sender: sender,
      );
      messages.insert(0, requestMessage);
      emit(
        state.copyWith(
          status: Status.succes,
          messages: messages,
        ),
      );
      emit(
        state.copyWith(
          status: Status.loading,
          messages: messages,
        ),
      );

      streamSubscription = chatGptRepository
          .chatStreamConverted(
        text: message,
        token: apiKey,
      )
          .listen(
        (response) {
          final MessageModel responseMessage = MessageModel(
            message: response.message,
            sender: response.sender,
          );

          messages.insert(0, responseMessage);

          emit(
            state.copyWith(
              messages: messages,
              status: Status.succes,
            ),
          );
        },
      )..onError(
          (error) {
            emit(
              state.copyWith(
                status: Status.error,
                errorMessage: error.toString(),
              ),
            );
          },
        );
    }
  }

  Future<void> launchOpenAiUrl() async {
    final Uri url = Uri.parse('https://beta.openai.com/account/api-keys');

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
