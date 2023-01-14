import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_model.freezed.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String message,
    required String sender,
  }) = _MessageModel;
}
