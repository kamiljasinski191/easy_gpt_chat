import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
part 'tokens_model.freezed.dart';
part 'tokens_model.g.dart';

@freezed
class TokensModel with _$TokensModel {
  @HiveType(
    typeId: 1,
    adapterName: 'TokensModelAdapter',
  )
  const factory TokensModel({
    @HiveField(0) @JsonKey(name: 'free_tokens') @Default(2) int freeTokens,
    @HiveField(1)
    @JsonKey(name: 'premium_tokens')
    @Default(0)
        int premiumTokens,
  }) = _TokensModel;

  factory TokensModel.fromJson(Map<String, Object?> json) =>
      _$TokensModelFromJson(json);
}
