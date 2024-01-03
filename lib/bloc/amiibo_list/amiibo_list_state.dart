import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amiibo_list_state.freezed.dart';

@freezed
sealed class AmiiboListState with _$AmiiboListState {
  const factory AmiiboListState.initial() = AmiiboListStateInitial;

  const factory AmiiboListState.success(List<AmiiboModel> amiiboList) =
      AmiiboListStateSuccess;

  const factory AmiiboListState.error() = AmiiboListStateError;
}
