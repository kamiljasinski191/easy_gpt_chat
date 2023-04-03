// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokensModel _$TokensModelFromJson(Map<String, dynamic> json) {
  return _TokensModel.fromJson(json);
}

/// @nodoc
mixin _$TokensModel {
  int get freeTokens => throw _privateConstructorUsedError;
  int get premiumTokens => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokensModelCopyWith<TokensModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensModelCopyWith<$Res> {
  factory $TokensModelCopyWith(
          TokensModel value, $Res Function(TokensModel) then) =
      _$TokensModelCopyWithImpl<$Res, TokensModel>;
  @useResult
  $Res call({int freeTokens, int premiumTokens});
}

/// @nodoc
class _$TokensModelCopyWithImpl<$Res, $Val extends TokensModel>
    implements $TokensModelCopyWith<$Res> {
  _$TokensModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? freeTokens = null,
    Object? premiumTokens = null,
  }) {
    return _then(_value.copyWith(
      freeTokens: null == freeTokens
          ? _value.freeTokens
          : freeTokens // ignore: cast_nullable_to_non_nullable
              as int,
      premiumTokens: null == premiumTokens
          ? _value.premiumTokens
          : premiumTokens // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokensModelCopyWith<$Res>
    implements $TokensModelCopyWith<$Res> {
  factory _$$_TokensModelCopyWith(
          _$_TokensModel value, $Res Function(_$_TokensModel) then) =
      __$$_TokensModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int freeTokens, int premiumTokens});
}

/// @nodoc
class __$$_TokensModelCopyWithImpl<$Res>
    extends _$TokensModelCopyWithImpl<$Res, _$_TokensModel>
    implements _$$_TokensModelCopyWith<$Res> {
  __$$_TokensModelCopyWithImpl(
      _$_TokensModel _value, $Res Function(_$_TokensModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? freeTokens = null,
    Object? premiumTokens = null,
  }) {
    return _then(_$_TokensModel(
      freeTokens: null == freeTokens
          ? _value.freeTokens
          : freeTokens // ignore: cast_nullable_to_non_nullable
              as int,
      premiumTokens: null == premiumTokens
          ? _value.premiumTokens
          : premiumTokens // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokensModel implements _TokensModel {
  const _$_TokensModel({this.freeTokens = 2, this.premiumTokens = 0});

  factory _$_TokensModel.fromJson(Map<String, dynamic> json) =>
      _$$_TokensModelFromJson(json);

  @override
  @JsonKey()
  final int freeTokens;
  @override
  @JsonKey()
  final int premiumTokens;

  @override
  String toString() {
    return 'TokensModel(freeTokens: $freeTokens, premiumTokens: $premiumTokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokensModel &&
            (identical(other.freeTokens, freeTokens) ||
                other.freeTokens == freeTokens) &&
            (identical(other.premiumTokens, premiumTokens) ||
                other.premiumTokens == premiumTokens));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, freeTokens, premiumTokens);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokensModelCopyWith<_$_TokensModel> get copyWith =>
      __$$_TokensModelCopyWithImpl<_$_TokensModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokensModelToJson(
      this,
    );
  }
}

abstract class _TokensModel implements TokensModel {
  const factory _TokensModel({final int freeTokens, final int premiumTokens}) =
      _$_TokensModel;

  factory _TokensModel.fromJson(Map<String, dynamic> json) =
      _$_TokensModel.fromJson;

  @override
  int get freeTokens;
  @override
  int get premiumTokens;
  @override
  @JsonKey(ignore: true)
  _$$_TokensModelCopyWith<_$_TokensModel> get copyWith =>
      throw _privateConstructorUsedError;
}
