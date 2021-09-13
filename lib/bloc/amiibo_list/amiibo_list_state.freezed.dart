// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'amiibo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AmiiboListStateTearOff {
  const _$AmiiboListStateTearOff();

  AmiiboListStateInitial initial() {
    return const AmiiboListStateInitial();
  }

  AmiiboListStateSuccess success(List<AmiiboModel> amiiboList) {
    return AmiiboListStateSuccess(
      amiiboList,
    );
  }

  AmiiboListStateError error() {
    return const AmiiboListStateError();
  }
}

/// @nodoc
const $AmiiboListState = _$AmiiboListStateTearOff();

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
      _$AmiiboListStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmiiboListStateCopyWithImpl<$Res>
    implements $AmiiboListStateCopyWith<$Res> {
  _$AmiiboListStateCopyWithImpl(this._value, this._then);

  final AmiiboListState _value;
  // ignore: unused_field
  final $Res Function(AmiiboListState) _then;
}

/// @nodoc
abstract class $AmiiboListStateInitialCopyWith<$Res> {
  factory $AmiiboListStateInitialCopyWith(AmiiboListStateInitial value,
          $Res Function(AmiiboListStateInitial) then) =
      _$AmiiboListStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmiiboListStateInitialCopyWithImpl<$Res>
    extends _$AmiiboListStateCopyWithImpl<$Res>
    implements $AmiiboListStateInitialCopyWith<$Res> {
  _$AmiiboListStateInitialCopyWithImpl(AmiiboListStateInitial _value,
      $Res Function(AmiiboListStateInitial) _then)
      : super(_value, (v) => _then(v as AmiiboListStateInitial));

  @override
  AmiiboListStateInitial get _value => super._value as AmiiboListStateInitial;
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
    return identical(this, other) || (other is AmiiboListStateInitial);
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
abstract class $AmiiboListStateSuccessCopyWith<$Res> {
  factory $AmiiboListStateSuccessCopyWith(AmiiboListStateSuccess value,
          $Res Function(AmiiboListStateSuccess) then) =
      _$AmiiboListStateSuccessCopyWithImpl<$Res>;
  $Res call({List<AmiiboModel> amiiboList});
}

/// @nodoc
class _$AmiiboListStateSuccessCopyWithImpl<$Res>
    extends _$AmiiboListStateCopyWithImpl<$Res>
    implements $AmiiboListStateSuccessCopyWith<$Res> {
  _$AmiiboListStateSuccessCopyWithImpl(AmiiboListStateSuccess _value,
      $Res Function(AmiiboListStateSuccess) _then)
      : super(_value, (v) => _then(v as AmiiboListStateSuccess));

  @override
  AmiiboListStateSuccess get _value => super._value as AmiiboListStateSuccess;

  @override
  $Res call({
    Object? amiiboList = freezed,
  }) {
    return _then(AmiiboListStateSuccess(
      amiiboList == freezed
          ? _value.amiiboList
          : amiiboList // ignore: cast_nullable_to_non_nullable
              as List<AmiiboModel>,
    ));
  }
}

/// @nodoc

class _$AmiiboListStateSuccess implements AmiiboListStateSuccess {
  const _$AmiiboListStateSuccess(this.amiiboList);

  @override
  final List<AmiiboModel> amiiboList;

  @override
  String toString() {
    return 'AmiiboListState.success(amiiboList: $amiiboList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AmiiboListStateSuccess &&
            (identical(other.amiiboList, amiiboList) ||
                const DeepCollectionEquality()
                    .equals(other.amiiboList, amiiboList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(amiiboList);

  @JsonKey(ignore: true)
  @override
  $AmiiboListStateSuccessCopyWith<AmiiboListStateSuccess> get copyWith =>
      _$AmiiboListStateSuccessCopyWithImpl<AmiiboListStateSuccess>(
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
  const factory AmiiboListStateSuccess(List<AmiiboModel> amiiboList) =
      _$AmiiboListStateSuccess;

  List<AmiiboModel> get amiiboList => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AmiiboListStateSuccessCopyWith<AmiiboListStateSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmiiboListStateErrorCopyWith<$Res> {
  factory $AmiiboListStateErrorCopyWith(AmiiboListStateError value,
          $Res Function(AmiiboListStateError) then) =
      _$AmiiboListStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$AmiiboListStateErrorCopyWithImpl<$Res>
    extends _$AmiiboListStateCopyWithImpl<$Res>
    implements $AmiiboListStateErrorCopyWith<$Res> {
  _$AmiiboListStateErrorCopyWithImpl(
      AmiiboListStateError _value, $Res Function(AmiiboListStateError) _then)
      : super(_value, (v) => _then(v as AmiiboListStateError));

  @override
  AmiiboListStateError get _value => super._value as AmiiboListStateError;
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
    return identical(this, other) || (other is AmiiboListStateError);
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
