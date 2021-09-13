// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'amiibo_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AmiiboItemStateTearOff {
  const _$AmiiboItemStateTearOff();

  AmiiboItemStateInitial initial() {
    return const AmiiboItemStateInitial();
  }

  AmiiboItemStateSuccess success(AmiiboModel amiiboItem) {
    return AmiiboItemStateSuccess(
      amiiboItem,
    );
  }

  AmiiboItemStateError error() {
    return const AmiiboItemStateError();
  }
}

/// @nodoc
const $AmiiboItemState = _$AmiiboItemStateTearOff();

/// @nodoc
mixin _$AmiiboItemState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AmiiboModel amiiboItem) success,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AmiiboModel amiiboItem)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboItemStateInitial value) initial,
    required TResult Function(AmiiboItemStateSuccess value) success,
    required TResult Function(AmiiboItemStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboItemStateInitial value)? initial,
    TResult Function(AmiiboItemStateSuccess value)? success,
    TResult Function(AmiiboItemStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmiiboItemStateCopyWith<$Res> {
  factory $AmiiboItemStateCopyWith(
          AmiiboItemState value, $Res Function(AmiiboItemState) then) =
      _$AmiiboItemStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmiiboItemStateCopyWithImpl<$Res>
    implements $AmiiboItemStateCopyWith<$Res> {
  _$AmiiboItemStateCopyWithImpl(this._value, this._then);

  final AmiiboItemState _value;
  // ignore: unused_field
  final $Res Function(AmiiboItemState) _then;
}

/// @nodoc
abstract class $AmiiboItemStateInitialCopyWith<$Res> {
  factory $AmiiboItemStateInitialCopyWith(AmiiboItemStateInitial value,
          $Res Function(AmiiboItemStateInitial) then) =
      _$AmiiboItemStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmiiboItemStateInitialCopyWithImpl<$Res>
    extends _$AmiiboItemStateCopyWithImpl<$Res>
    implements $AmiiboItemStateInitialCopyWith<$Res> {
  _$AmiiboItemStateInitialCopyWithImpl(AmiiboItemStateInitial _value,
      $Res Function(AmiiboItemStateInitial) _then)
      : super(_value, (v) => _then(v as AmiiboItemStateInitial));

  @override
  AmiiboItemStateInitial get _value => super._value as AmiiboItemStateInitial;
}

/// @nodoc

class _$AmiiboItemStateInitial implements AmiiboItemStateInitial {
  const _$AmiiboItemStateInitial();

  @override
  String toString() {
    return 'AmiiboItemState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AmiiboItemStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AmiiboModel amiiboItem) success,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AmiiboModel amiiboItem)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboItemStateInitial value) initial,
    required TResult Function(AmiiboItemStateSuccess value) success,
    required TResult Function(AmiiboItemStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboItemStateInitial value)? initial,
    TResult Function(AmiiboItemStateSuccess value)? success,
    TResult Function(AmiiboItemStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AmiiboItemStateInitial implements AmiiboItemState {
  const factory AmiiboItemStateInitial() = _$AmiiboItemStateInitial;
}

/// @nodoc
abstract class $AmiiboItemStateSuccessCopyWith<$Res> {
  factory $AmiiboItemStateSuccessCopyWith(AmiiboItemStateSuccess value,
          $Res Function(AmiiboItemStateSuccess) then) =
      _$AmiiboItemStateSuccessCopyWithImpl<$Res>;
  $Res call({AmiiboModel amiiboItem});
}

/// @nodoc
class _$AmiiboItemStateSuccessCopyWithImpl<$Res>
    extends _$AmiiboItemStateCopyWithImpl<$Res>
    implements $AmiiboItemStateSuccessCopyWith<$Res> {
  _$AmiiboItemStateSuccessCopyWithImpl(AmiiboItemStateSuccess _value,
      $Res Function(AmiiboItemStateSuccess) _then)
      : super(_value, (v) => _then(v as AmiiboItemStateSuccess));

  @override
  AmiiboItemStateSuccess get _value => super._value as AmiiboItemStateSuccess;

  @override
  $Res call({
    Object? amiiboItem = freezed,
  }) {
    return _then(AmiiboItemStateSuccess(
      amiiboItem == freezed
          ? _value.amiiboItem
          : amiiboItem // ignore: cast_nullable_to_non_nullable
              as AmiiboModel,
    ));
  }
}

/// @nodoc

class _$AmiiboItemStateSuccess implements AmiiboItemStateSuccess {
  const _$AmiiboItemStateSuccess(this.amiiboItem);

  @override
  final AmiiboModel amiiboItem;

  @override
  String toString() {
    return 'AmiiboItemState.success(amiiboItem: $amiiboItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AmiiboItemStateSuccess &&
            (identical(other.amiiboItem, amiiboItem) ||
                const DeepCollectionEquality()
                    .equals(other.amiiboItem, amiiboItem)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(amiiboItem);

  @JsonKey(ignore: true)
  @override
  $AmiiboItemStateSuccessCopyWith<AmiiboItemStateSuccess> get copyWith =>
      _$AmiiboItemStateSuccessCopyWithImpl<AmiiboItemStateSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AmiiboModel amiiboItem) success,
    required TResult Function() error,
  }) {
    return success(amiiboItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AmiiboModel amiiboItem)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(amiiboItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboItemStateInitial value) initial,
    required TResult Function(AmiiboItemStateSuccess value) success,
    required TResult Function(AmiiboItemStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboItemStateInitial value)? initial,
    TResult Function(AmiiboItemStateSuccess value)? success,
    TResult Function(AmiiboItemStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AmiiboItemStateSuccess implements AmiiboItemState {
  const factory AmiiboItemStateSuccess(AmiiboModel amiiboItem) =
      _$AmiiboItemStateSuccess;

  AmiiboModel get amiiboItem => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AmiiboItemStateSuccessCopyWith<AmiiboItemStateSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmiiboItemStateErrorCopyWith<$Res> {
  factory $AmiiboItemStateErrorCopyWith(AmiiboItemStateError value,
          $Res Function(AmiiboItemStateError) then) =
      _$AmiiboItemStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmiiboItemStateErrorCopyWithImpl<$Res>
    extends _$AmiiboItemStateCopyWithImpl<$Res>
    implements $AmiiboItemStateErrorCopyWith<$Res> {
  _$AmiiboItemStateErrorCopyWithImpl(
      AmiiboItemStateError _value, $Res Function(AmiiboItemStateError) _then)
      : super(_value, (v) => _then(v as AmiiboItemStateError));

  @override
  AmiiboItemStateError get _value => super._value as AmiiboItemStateError;
}

/// @nodoc

class _$AmiiboItemStateError implements AmiiboItemStateError {
  const _$AmiiboItemStateError();

  @override
  String toString() {
    return 'AmiiboItemState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AmiiboItemStateError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AmiiboModel amiiboItem) success,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AmiiboModel amiiboItem)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboItemStateInitial value) initial,
    required TResult Function(AmiiboItemStateSuccess value) success,
    required TResult Function(AmiiboItemStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboItemStateInitial value)? initial,
    TResult Function(AmiiboItemStateSuccess value)? success,
    TResult Function(AmiiboItemStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AmiiboItemStateError implements AmiiboItemState {
  const factory AmiiboItemStateError() = _$AmiiboItemStateError;
}
