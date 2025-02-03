part of 'amiibo_item_cubit.dart';

sealed class AmiiboItemState with EquatableMixin {
  const AmiiboItemState();

  @override
  List<Object?> get props => [];
}

final class AmiiboItemStateInitial extends AmiiboItemState {
  const AmiiboItemStateInitial();
}

final class AmiiboItemStateSuccess extends AmiiboItemState {
  const AmiiboItemStateSuccess({required this.amiiboItem});

  final AmiiboModel amiiboItem;

  @override
  List<Object?> get props => [amiiboItem];
}

final class AmiiboItemStateError extends AmiiboItemState {
  const AmiiboItemStateError();
}
