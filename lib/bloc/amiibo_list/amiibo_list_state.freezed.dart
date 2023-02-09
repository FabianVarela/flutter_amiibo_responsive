// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amiibo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AmiiboListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AmiiboModel> amiiboList) success,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AmiiboModel> amiiboList)? success,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AmiiboModel> amiiboList)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboListStateInitial value) initial,
    required TResult Function(AmiiboListStateSuccess value) success,
    required TResult Function(AmiiboListStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboListStateInitial value)? initial,
    TResult? Function(AmiiboListStateSuccess value)? success,
    TResult? Function(AmiiboListStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboListStateInitial value)? initial,
    TResult Function(AmiiboListStateSuccess value)? success,
    TResult Function(AmiiboListStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmiiboListStateCopyWith<$Res> {
  factory $AmiiboListStateCopyWith(
          AmiiboListState value, $Res Function(AmiiboListState) then) =
      _$AmiiboListStateCopyWithImpl<$Res, AmiiboListState>;
}

/// @nodoc
class _$AmiiboListStateCopyWithImpl<$Res, $Val extends AmiiboListState>
    implements $AmiiboListStateCopyWith<$Res> {
  _$AmiiboListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AmiiboListStateInitialCopyWith<$Res> {
  factory _$$AmiiboListStateInitialCopyWith(_$AmiiboListStateInitial value,
          $Res Function(_$AmiiboListStateInitial) then) =
      __$$AmiiboListStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AmiiboListStateInitialCopyWithImpl<$Res>
    extends _$AmiiboListStateCopyWithImpl<$Res, _$AmiiboListStateInitial>
    implements _$$AmiiboListStateInitialCopyWith<$Res> {
  __$$AmiiboListStateInitialCopyWithImpl(_$AmiiboListStateInitial _value,
      $Res Function(_$AmiiboListStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AmiiboListStateInitial implements AmiiboListStateInitial {
  const _$AmiiboListStateInitial();

  @override
  String toString() {
    return 'AmiiboListState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AmiiboListStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AmiiboModel> amiiboList) success,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AmiiboModel> amiiboList)? success,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AmiiboModel> amiiboList)? success,
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
    required TResult Function(AmiiboListStateInitial value) initial,
    required TResult Function(AmiiboListStateSuccess value) success,
    required TResult Function(AmiiboListStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboListStateInitial value)? initial,
    TResult? Function(AmiiboListStateSuccess value)? success,
    TResult? Function(AmiiboListStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboListStateInitial value)? initial,
    TResult Function(AmiiboListStateSuccess value)? success,
    TResult Function(AmiiboListStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AmiiboListStateInitial implements AmiiboListState {
  const factory AmiiboListStateInitial() = _$AmiiboListStateInitial;
}

/// @nodoc
abstract class _$$AmiiboListStateSuccessCopyWith<$Res> {
  factory _$$AmiiboListStateSuccessCopyWith(_$AmiiboListStateSuccess value,
          $Res Function(_$AmiiboListStateSuccess) then) =
      __$$AmiiboListStateSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AmiiboModel> amiiboList});
}

/// @nodoc
class __$$AmiiboListStateSuccessCopyWithImpl<$Res>
    extends _$AmiiboListStateCopyWithImpl<$Res, _$AmiiboListStateSuccess>
    implements _$$AmiiboListStateSuccessCopyWith<$Res> {
  __$$AmiiboListStateSuccessCopyWithImpl(_$AmiiboListStateSuccess _value,
      $Res Function(_$AmiiboListStateSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amiiboList = null,
  }) {
    return _then(_$AmiiboListStateSuccess(
      null == amiiboList
          ? _value._amiiboList
          : amiiboList // ignore: cast_nullable_to_non_nullable
              as List<AmiiboModel>,
    ));
  }
}

/// @nodoc

class _$AmiiboListStateSuccess implements AmiiboListStateSuccess {
  const _$AmiiboListStateSuccess(final List<AmiiboModel> amiiboList)
      : _amiiboList = amiiboList;

  final List<AmiiboModel> _amiiboList;
  @override
  List<AmiiboModel> get amiiboList {
    if (_amiiboList is EqualUnmodifiableListView) return _amiiboList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amiiboList);
  }

  @override
  String toString() {
    return 'AmiiboListState.success(amiiboList: $amiiboList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmiiboListStateSuccess &&
            const DeepCollectionEquality()
                .equals(other._amiiboList, _amiiboList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_amiiboList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmiiboListStateSuccessCopyWith<_$AmiiboListStateSuccess> get copyWith =>
      __$$AmiiboListStateSuccessCopyWithImpl<_$AmiiboListStateSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AmiiboModel> amiiboList) success,
    required TResult Function() error,
  }) {
    return success(amiiboList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AmiiboModel> amiiboList)? success,
    TResult? Function()? error,
  }) {
    return success?.call(amiiboList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AmiiboModel> amiiboList)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(amiiboList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AmiiboListStateInitial value) initial,
    required TResult Function(AmiiboListStateSuccess value) success,
    required TResult Function(AmiiboListStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboListStateInitial value)? initial,
    TResult? Function(AmiiboListStateSuccess value)? success,
    TResult? Function(AmiiboListStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboListStateInitial value)? initial,
    TResult Function(AmiiboListStateSuccess value)? success,
    TResult Function(AmiiboListStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AmiiboListStateSuccess implements AmiiboListState {
  const factory AmiiboListStateSuccess(final List<AmiiboModel> amiiboList) =
      _$AmiiboListStateSuccess;

  List<AmiiboModel> get amiiboList;
  @JsonKey(ignore: true)
  _$$AmiiboListStateSuccessCopyWith<_$AmiiboListStateSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AmiiboListStateErrorCopyWith<$Res> {
  factory _$$AmiiboListStateErrorCopyWith(_$AmiiboListStateError value,
          $Res Function(_$AmiiboListStateError) then) =
      __$$AmiiboListStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AmiiboListStateErrorCopyWithImpl<$Res>
    extends _$AmiiboListStateCopyWithImpl<$Res, _$AmiiboListStateError>
    implements _$$AmiiboListStateErrorCopyWith<$Res> {
  __$$AmiiboListStateErrorCopyWithImpl(_$AmiiboListStateError _value,
      $Res Function(_$AmiiboListStateError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AmiiboListStateError implements AmiiboListStateError {
  const _$AmiiboListStateError();

  @override
  String toString() {
    return 'AmiiboListState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AmiiboListStateError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<AmiiboModel> amiiboList) success,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<AmiiboModel> amiiboList)? success,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<AmiiboModel> amiiboList)? success,
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
    required TResult Function(AmiiboListStateInitial value) initial,
    required TResult Function(AmiiboListStateSuccess value) success,
    required TResult Function(AmiiboListStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AmiiboListStateInitial value)? initial,
    TResult? Function(AmiiboListStateSuccess value)? success,
    TResult? Function(AmiiboListStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AmiiboListStateInitial value)? initial,
    TResult Function(AmiiboListStateSuccess value)? success,
    TResult Function(AmiiboListStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AmiiboListStateError implements AmiiboListState {
  const factory AmiiboListStateError() = _$AmiiboListStateError;
}
