import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domains/models/message_model.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._chatGptRepository) : super(const ChatState());

  final ChatGptRepository _chatGptRepository;

  StreamSubscription? _streamSubscription;

  List<MessageModel> messages = [];

  Future<void> sendMessage({required String message}) async {
    emit(
      const ChatState(status: Status.loading),
    );

  
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      emit(state.copyWith(status: Status.noInternet));
    } else {
      _streamSubscription =
          _chatGptRepository.streamConverted(text: message).listen((response) {
        MessageModel userMessage =
            MessageModel(message: message, sender: 'user');

        MessageModel botMessage =
            MessageModel(message: response.message, sender: response.sender);

        emit(state.copyWith(messages: messages, status: Status.succes));
       
        messages.clear();
        messages.insert(0, userMessage);
        messages.insert(0, botMessage);
      });
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
