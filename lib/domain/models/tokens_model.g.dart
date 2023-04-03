// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokensModel _$$_TokensModelFromJson(Map<String, dynamic> json) =>
    _$_TokensModel(
      freeTokens: json['freeTokens'] as int? ?? 2,
      premiumTokens: json['premiumTokens'] as int? ?? 0,
    );

Map<String, dynamic> _$$_TokensModelToJson(_$_TokensModel instance) =>
    <String, dynamic>{
      'freeTokens': instance.freeTokens,
      'premiumTokens': instance.premiumTokens,
    };
