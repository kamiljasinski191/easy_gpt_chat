part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(Status.initial) Status status,
    @Default([]) List<MessageModel> messages,
    String? errorMessage,
  }) = _ChatState;
}
