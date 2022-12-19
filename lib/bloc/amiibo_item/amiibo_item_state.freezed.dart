// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'amiibo_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AmiiboModel amiiboItem)? success,
    TResult? Function()? error,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboItemStateInitial value)? initial,
    TResult? Function(AmiiboItemStateSuccess value)? success,
    TResult? Function(AmiiboItemStateError value)? error,
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
      _$AmiiboItemStateCopyWithImpl<$Res, AmiiboItemState>;
}

/// @nodoc
class _$AmiiboItemStateCopyWithImpl<$Res, $Val extends AmiiboItemState>
    implements $AmiiboItemStateCopyWith<$Res> {
  _$AmiiboItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AmiiboItemStateInitialCopyWith<$Res> {
  factory _$$AmiiboItemStateInitialCopyWith(_$AmiiboItemStateInitial value,
          $Res Function(_$AmiiboItemStateInitial) then) =
      __$$AmiiboItemStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AmiiboItemStateInitialCopyWithImpl<$Res>
    extends _$AmiiboItemStateCopyWithImpl<$Res, _$AmiiboItemStateInitial>
    implements _$$AmiiboItemStateInitialCopyWith<$Res> {
  __$$AmiiboItemStateInitialCopyWithImpl(_$AmiiboItemStateInitial _value,
      $Res Function(_$AmiiboItemStateInitial) _then)
      : super(_value, _then);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AmiiboItemStateInitial);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AmiiboModel amiiboItem)? success,
    TResult? Function()? error,
  }) {
    return initial?.call();
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboItemStateInitial value)? initial,
    TResult? Function(AmiiboItemStateSuccess value)? success,
    TResult? Function(AmiiboItemStateError value)? error,
  }) {
    return initial?.call(this);
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
abstract class _$$AmiiboItemStateSuccessCopyWith<$Res> {
  factory _$$AmiiboItemStateSuccessCopyWith(_$AmiiboItemStateSuccess value,
          $Res Function(_$AmiiboItemStateSuccess) then) =
      __$$AmiiboItemStateSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({AmiiboModel amiiboItem});
}

/// @nodoc
class __$$AmiiboItemStateSuccessCopyWithImpl<$Res>
    extends _$AmiiboItemStateCopyWithImpl<$Res, _$AmiiboItemStateSuccess>
    implements _$$AmiiboItemStateSuccessCopyWith<$Res> {
  __$$AmiiboItemStateSuccessCopyWithImpl(_$AmiiboItemStateSuccess _value,
      $Res Function(_$AmiiboItemStateSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amiiboItem = null,
  }) {
    return _then(_$AmiiboItemStateSuccess(
      null == amiiboItem
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
        (other.runtimeType == runtimeType &&
            other is _$AmiiboItemStateSuccess &&
            (identical(other.amiiboItem, amiiboItem) ||
                other.amiiboItem == amiiboItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amiiboItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmiiboItemStateSuccessCopyWith<_$AmiiboItemStateSuccess> get copyWith =>
      __$$AmiiboItemStateSuccessCopyWithImpl<_$AmiiboItemStateSuccess>(
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AmiiboModel amiiboItem)? success,
    TResult? Function()? error,
  }) {
    return success?.call(amiiboItem);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboItemStateInitial value)? initial,
    TResult? Function(AmiiboItemStateSuccess value)? success,
    TResult? Function(AmiiboItemStateError value)? error,
  }) {
    return success?.call(this);
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
  const factory AmiiboItemStateSuccess(final AmiiboModel amiiboItem) =
      _$AmiiboItemStateSuccess;

  AmiiboModel get amiiboItem;
  @JsonKey(ignore: true)
  _$$AmiiboItemStateSuccessCopyWith<_$AmiiboItemStateSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmiiboItemStateErrorCopyWith<$Res> {
  factory _$$AmiiboItemStateErrorCopyWith(_$AmiiboItemStateError value,
          $Res Function(_$AmiiboItemStateError) then) =
      __$$AmiiboItemStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AmiiboItemStateErrorCopyWithImpl<$Res>
    extends _$AmiiboItemStateCopyWithImpl<$Res, _$AmiiboItemStateError>
    implements _$$AmiiboItemStateErrorCopyWith<$Res> {
  __$$AmiiboItemStateErrorCopyWithImpl(_$AmiiboItemStateError _value,
      $Res Function(_$AmiiboItemStateError) _then)
      : super(_value, _then);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AmiiboItemStateError);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AmiiboModel amiiboItem)? success,
    TResult? Function()? error,
  }) {
    return error?.call();
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboItemStateInitial value)? initial,
    TResult? Function(AmiiboItemStateSuccess value)? success,
    TResult? Function(AmiiboItemStateError value)? error,
  }) {
    return error?.call(this);
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
