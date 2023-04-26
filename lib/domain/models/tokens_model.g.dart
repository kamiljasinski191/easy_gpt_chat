// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokensModelAdapter extends TypeAdapter<_$_TokensModel> {
  @override
  final int typeId = 1;

  @override
  _$_TokensModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TokensModel(
      freeTokens: fields[0] as int,
      premiumTokens: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TokensModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.freeTokens)
      ..writeByte(1)
      ..write(obj.premiumTokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokensModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokensModel _$$_TokensModelFromJson(Map<String, dynamic> json) =>
    _$_TokensModel(
      freeTokens: json['free_tokens'] as int? ?? 2,
      premiumTokens: json['premium_tokens'] as int? ?? 0,
    );

Map<String, dynamic> _$$_TokensModelToJson(_$_TokensModel instance) =>
    <String, dynamic>{
      'free_tokens': instance.freeTokens,
      'premium_tokens': instance.premiumTokens,
    };
