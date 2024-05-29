import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

sealed class AmiiboItemState extends Equatable {
  const AmiiboItemState();

  @override
  List<Object?> get props => [];
}

class AmiiboItemStateInitial extends AmiiboItemState {
  const AmiiboItemStateInitial();
}

class AmiiboItemStateSuccess extends AmiiboItemState {
  const AmiiboItemStateSuccess({required this.amiiboItem});

  final AmiiboModel amiiboItem;

  @override
  List<Object?> get props => [amiiboItem];
}

class AmiiboItemStateError extends AmiiboItemState {
  const AmiiboItemStateError();
}
