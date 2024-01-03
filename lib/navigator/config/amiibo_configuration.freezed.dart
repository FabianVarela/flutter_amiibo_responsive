// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amiibo_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AmiiboConfiguration {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? type) home,
    required TResult Function(String amiiboId, String? type) detail,
    required TResult Function() unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? type)? home,
    TResult? Function(String amiiboId, String? type)? detail,
    TResult? Function()? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? type)? home,
    TResult Function(String amiiboId, String? type)? detail,
    TResult Function()? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboConfigurationHome value) home,
    required TResult Function(AmiiboConfigurationDetail value) detail,
    required TResult Function(AmiiboConfigurationUnknown value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboConfigurationHome value)? home,
    TResult? Function(AmiiboConfigurationDetail value)? detail,
    TResult? Function(AmiiboConfigurationUnknown value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboConfigurationHome value)? home,
    TResult Function(AmiiboConfigurationDetail value)? detail,
    TResult Function(AmiiboConfigurationUnknown value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmiiboConfigurationCopyWith<$Res> {
  factory $AmiiboConfigurationCopyWith(
          AmiiboConfiguration value, $Res Function(AmiiboConfiguration) then) =
      _$AmiiboConfigurationCopyWithImpl<$Res, AmiiboConfiguration>;
}

/// @nodoc
class _$AmiiboConfigurationCopyWithImpl<$Res, $Val extends AmiiboConfiguration>
    implements $AmiiboConfigurationCopyWith<$Res> {
  _$AmiiboConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AmiiboConfigurationHomeImplCopyWith<$Res> {
  factory _$$AmiiboConfigurationHomeImplCopyWith(
          _$AmiiboConfigurationHomeImpl value,
          $Res Function(_$AmiiboConfigurationHomeImpl) then) =
      __$$AmiiboConfigurationHomeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? type});
}

/// @nodoc
class __$$AmiiboConfigurationHomeImplCopyWithImpl<$Res>
    extends _$AmiiboConfigurationCopyWithImpl<$Res,
        _$AmiiboConfigurationHomeImpl>
    implements _$$AmiiboConfigurationHomeImplCopyWith<$Res> {
  __$$AmiiboConfigurationHomeImplCopyWithImpl(
      _$AmiiboConfigurationHomeImpl _value,
      $Res Function(_$AmiiboConfigurationHomeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_$AmiiboConfigurationHomeImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AmiiboConfigurationHomeImpl implements AmiiboConfigurationHome {
  const _$AmiiboConfigurationHomeImpl({this.type});

  @override
  final String? type;

  @override
  String toString() {
    return 'AmiiboConfiguration.home(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmiiboConfigurationHomeImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmiiboConfigurationHomeImplCopyWith<_$AmiiboConfigurationHomeImpl>
      get copyWith => __$$AmiiboConfigurationHomeImplCopyWithImpl<
          _$AmiiboConfigurationHomeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? type) home,
    required TResult Function(String amiiboId, String? type) detail,
    required TResult Function() unknown,
  }) {
    return home(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? type)? home,
    TResult? Function(String amiiboId, String? type)? detail,
    TResult? Function()? unknown,
  }) {
    return home?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? type)? home,
    TResult Function(String amiiboId, String? type)? detail,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboConfigurationHome value) home,
    required TResult Function(AmiiboConfigurationDetail value) detail,
    required TResult Function(AmiiboConfigurationUnknown value) unknown,
  }) {
    return home(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboConfigurationHome value)? home,
    TResult? Function(AmiiboConfigurationDetail value)? detail,
    TResult? Function(AmiiboConfigurationUnknown value)? unknown,
  }) {
    return home?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboConfigurationHome value)? home,
    TResult Function(AmiiboConfigurationDetail value)? detail,
    TResult Function(AmiiboConfigurationUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home(this);
    }
    return orElse();
  }
}

abstract class AmiiboConfigurationHome implements AmiiboConfiguration {
  const factory AmiiboConfigurationHome({final String? type}) =
      _$AmiiboConfigurationHomeImpl;

  String? get type;
  @JsonKey(ignore: true)
  _$$AmiiboConfigurationHomeImplCopyWith<_$AmiiboConfigurationHomeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmiiboConfigurationDetailImplCopyWith<$Res> {
  factory _$$AmiiboConfigurationDetailImplCopyWith(
          _$AmiiboConfigurationDetailImpl value,
          $Res Function(_$AmiiboConfigurationDetailImpl) then) =
      __$$AmiiboConfigurationDetailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String amiiboId, String? type});
}

/// @nodoc
class __$$AmiiboConfigurationDetailImplCopyWithImpl<$Res>
    extends _$AmiiboConfigurationCopyWithImpl<$Res,
        _$AmiiboConfigurationDetailImpl>
    implements _$$AmiiboConfigurationDetailImplCopyWith<$Res> {
  __$$AmiiboConfigurationDetailImplCopyWithImpl(
      _$AmiiboConfigurationDetailImpl _value,
      $Res Function(_$AmiiboConfigurationDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amiiboId = null,
    Object? type = freezed,
  }) {
    return _then(_$AmiiboConfigurationDetailImpl(
      null == amiiboId
          ? _value.amiiboId
          : amiiboId // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AmiiboConfigurationDetailImpl implements AmiiboConfigurationDetail {
  const _$AmiiboConfigurationDetailImpl(this.amiiboId, {this.type});

  @override
  final String amiiboId;
  @override
  final String? type;

  @override
  String toString() {
    return 'AmiiboConfiguration.detail(amiiboId: $amiiboId, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmiiboConfigurationDetailImpl &&
            (identical(other.amiiboId, amiiboId) ||
                other.amiiboId == amiiboId) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amiiboId, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmiiboConfigurationDetailImplCopyWith<_$AmiiboConfigurationDetailImpl>
      get copyWith => __$$AmiiboConfigurationDetailImplCopyWithImpl<
          _$AmiiboConfigurationDetailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? type) home,
    required TResult Function(String amiiboId, String? type) detail,
    required TResult Function() unknown,
  }) {
    return detail(amiiboId, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? type)? home,
    TResult? Function(String amiiboId, String? type)? detail,
    TResult? Function()? unknown,
  }) {
    return detail?.call(amiiboId, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? type)? home,
    TResult Function(String amiiboId, String? type)? detail,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    if (detail != null) {
      return detail(amiiboId, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboConfigurationHome value) home,
    required TResult Function(AmiiboConfigurationDetail value) detail,
    required TResult Function(AmiiboConfigurationUnknown value) unknown,
  }) {
    return detail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboConfigurationHome value)? home,
    TResult? Function(AmiiboConfigurationDetail value)? detail,
    TResult? Function(AmiiboConfigurationUnknown value)? unknown,
  }) {
    return detail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboConfigurationHome value)? home,
    TResult Function(AmiiboConfigurationDetail value)? detail,
    TResult Function(AmiiboConfigurationUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (detail != null) {
      return detail(this);
    }
    return orElse();
  }
}

abstract class AmiiboConfigurationDetail implements AmiiboConfiguration {
  const factory AmiiboConfigurationDetail(final String amiiboId,
      {final String? type}) = _$AmiiboConfigurationDetailImpl;

  String get amiiboId;
  String? get type;
  @JsonKey(ignore: true)
  _$$AmiiboConfigurationDetailImplCopyWith<_$AmiiboConfigurationDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmiiboConfigurationUnknownImplCopyWith<$Res> {
  factory _$$AmiiboConfigurationUnknownImplCopyWith(
          _$AmiiboConfigurationUnknownImpl value,
          $Res Function(_$AmiiboConfigurationUnknownImpl) then) =
      __$$AmiiboConfigurationUnknownImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AmiiboConfigurationUnknownImplCopyWithImpl<$Res>
    extends _$AmiiboConfigurationCopyWithImpl<$Res,
        _$AmiiboConfigurationUnknownImpl>
    implements _$$AmiiboConfigurationUnknownImplCopyWith<$Res> {
  __$$AmiiboConfigurationUnknownImplCopyWithImpl(
      _$AmiiboConfigurationUnknownImpl _value,
      $Res Function(_$AmiiboConfigurationUnknownImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AmiiboConfigurationUnknownImpl implements AmiiboConfigurationUnknown {
  const _$AmiiboConfigurationUnknownImpl();

  @override
  String toString() {
    return 'AmiiboConfiguration.unknown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmiiboConfigurationUnknownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? type) home,
    required TResult Function(String amiiboId, String? type) detail,
    required TResult Function() unknown,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? type)? home,
    TResult? Function(String amiiboId, String? type)? detail,
    TResult? Function()? unknown,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? type)? home,
    TResult Function(String amiiboId, String? type)? detail,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboConfigurationHome value) home,
    required TResult Function(AmiiboConfigurationDetail value) detail,
    required TResult Function(AmiiboConfigurationUnknown value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboConfigurationHome value)? home,
    TResult? Function(AmiiboConfigurationDetail value)? detail,
    TResult? Function(AmiiboConfigurationUnknown value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboConfigurationHome value)? home,
    TResult Function(AmiiboConfigurationDetail value)? detail,
    TResult Function(AmiiboConfigurationUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class AmiiboConfigurationUnknown implements AmiiboConfiguration {
  const factory AmiiboConfigurationUnknown() = _$AmiiboConfigurationUnknownImpl;
}
