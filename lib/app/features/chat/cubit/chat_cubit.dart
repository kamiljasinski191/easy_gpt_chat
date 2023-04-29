import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart';
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatGptRepository, this.authRepository)
      : super(const ChatState());

  final ChatGptRepository chatGptRepository;
  final AuthRepository authRepository;

  StreamSubscription? streamSubscription;

  List<MessageModel> messages = [];

  Future<void> start() async {
    messages.clear();
    emit(
      state.copyWith(
        status: Status.initial,
      ),
    );

    await setToken();

    emit(
      state.copyWith(
        status: Status.succes,
        messages: messages,
      ),
    );
  }

  Future<void> setToken() async {
    await chatGptRepository.setToken();
  }

  Future<void> sendMessage({
    required String message,
    required String sender,
    required Function textFieldCleaner,
    required UserModel currentUser,
  }) async {
    if (currentUser.tokens.freeTokens > 0) {
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

          if (currentUser.email == 'guest') {
            authRepository.updateGuestUser(amount: -1);
          } else {
            final currentTokens = currentUser.tokens.freeTokens;
            authRepository.updateUserTokens(
              amount: -1,
              currentTokens: currentTokens,
            );
          }

          textFieldCleaner();

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
                final MessageModel errorMessage = MessageModel(
                  message: error.response?.data['error']['message'] ?? error,
                  sender: 'error',
                );
                messages.insert(0, errorMessage);
                emit(
                  state.copyWith(
                    messages: messages,
                    status: Status.succes,
                  ),
                );
              } else {
                final MessageModel errorMessage = MessageModel(
                  message:
                      error.message.substring(0, error.message.indexOf("[")),
                  sender: 'error',
                );
                messages.insert(0, errorMessage);
                emit(
                  state.copyWith(
                    messages: messages,
                    status: Status.succes,
                  ),
                );
              }
            } else {
              final MessageModel errorMessage = MessageModel(
                message: error.message ?? error,
                sender: 'error',
              );
              messages.insert(0, errorMessage);
              emit(
                state.copyWith(
                  messages: messages,
                  status: Status.succes,
                ),
              );
            }
          },
        );
    } else {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'No tokens. Get more watching short advertisement',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
