import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amiibo_item_state.freezed.dart';

@freezed
sealed class AmiiboItemState with _$AmiiboItemState {
  const factory AmiiboItemState.initial() = AmiiboItemStateInitial;

  const factory AmiiboItemState.success(AmiiboModel amiiboItem) =
      AmiiboItemStateSuccess;

  const factory AmiiboItemState.error() = AmiiboItemStateError;
}
