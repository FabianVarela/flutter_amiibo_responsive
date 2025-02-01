part of 'amiibo_list_cubit.dart';

sealed class AmiiboListState with EquatableMixin {
  const AmiiboListState();

  @override
  List<Object?> get props => [];
}

final class AmiiboListStateInitial extends AmiiboListState {
  const AmiiboListStateInitial();
}

final class AmiiboListStateSuccess extends AmiiboListState {
  const AmiiboListStateSuccess({required this.amiiboList});

  final List<AmiiboModel> amiiboList;

  @override
  List<Object?> get props => [amiiboList];
}

final class AmiiboListStateError extends AmiiboListState {
  const AmiiboListStateError();
}
