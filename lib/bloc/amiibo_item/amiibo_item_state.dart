part of 'amiibo_item_cubit.dart';

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
