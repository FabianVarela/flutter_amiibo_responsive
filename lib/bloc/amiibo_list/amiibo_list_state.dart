import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

sealed class AmiiboListState extends Equatable {
  const AmiiboListState();

  @override
  List<Object?> get props => [];
}

class AmiiboListStateInitial extends AmiiboListState {
  const AmiiboListStateInitial();
}

class AmiiboListStateSuccess extends AmiiboListState {
  const AmiiboListStateSuccess({required this.amiiboList});

  final List<AmiiboModel> amiiboList;

  @override
  List<Object?> get props => [amiiboList];
}

class AmiiboListStateError extends AmiiboListState {
  const AmiiboListStateError();
}
