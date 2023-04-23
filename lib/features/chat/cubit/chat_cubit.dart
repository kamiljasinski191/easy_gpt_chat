import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    this.chatGptRepository,
  ) : super(const ChatState());

  final ChatGptRepository chatGptRepository;

  StreamSubscription? streamSubscription;

  List<MessageModel> messages = [];

  Future<void> start() async {
    messages.clear();
    emit(
      state.copyWith(
        status: Status.initial,
      ),
    );
    bool hasConnection = await chatGptRepository.hasConnection();
    emit(
      state.copyWith(
        status: Status.loading,
        messages: messages,
      ),
    );
    if (!hasConnection) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'noInternet',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: Status.succes,
          messages: messages,
        ),
      );
    }
  }

  Future<void> sendMessage({
    required String message,
    required String sender,
  }) async {
    bool hasConnection = await chatGptRepository.hasConnection();

    if (!hasConnection) {
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
          status: Status.loading,
          messages: messages,
        ),
      );

      streamSubscription = chatGptRepository
          .chatStreamConverted(
        text: message,
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
            if (error is DioError) {
              if (error.response != null) {
                emit(state.copyWith(
                  status: Status.error,
                  errorMessage: error.response?.data['error']['message'],
                  errorCode: error.response?.data['error']['code'],
                ));
              } else {
                emit(
                  state.copyWith(
                    status: Status.error,
                    errorMessage: error.message,
                  ),
                );
              }
            }
          },
        );
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
