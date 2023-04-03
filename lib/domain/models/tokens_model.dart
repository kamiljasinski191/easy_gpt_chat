import 'package:freezed_annotation/freezed_annotation.dart';
part 'tokens_model.freezed.dart';
part 'tokens_model.g.dart';

@freezed
class TokensModel with _$TokensModel {
  const factory TokensModel({
    @Default(2) int freeTokens,
    @Default(0) int premiumTokens,
  }) = _TokensModel;

  factory TokensModel.fromJson(Map<String, Object?> json) =>
      _$TokensModelFromJson(json);
}
