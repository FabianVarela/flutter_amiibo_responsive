part of 'amiibo_item_cubit.dart';

sealed class AmiiboItemState with Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class AmiiboItemStateInitial extends AmiiboItemState {
  const new();
}

final class AmiiboItemStateSuccess extends AmiiboItemState {
  const new({required this.amiiboItem});

  final AmiiboModel amiiboItem;

  @override
  List<Object?> get props => [amiiboItem];
}

final class AmiiboItemStateError extends AmiiboItemState {
  const new();
}
