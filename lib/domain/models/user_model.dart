import 'package:easy_gpt_chat/domain/models/tokens_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @HiveType(
    typeId: 0,
    adapterName: 'UserModelAdapter',
  )
  const factory UserModel({
    @HiveField(0)
    @JsonKey(ignore: true)
    @Default('')
        String id,
    @HiveField(1)
        required String? email,
    @HiveField(2)
    // @JsonKey(ignore: true)
    @Default(TokensModel())
        TokensModel tokens,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
