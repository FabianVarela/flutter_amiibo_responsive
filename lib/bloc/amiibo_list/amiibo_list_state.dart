part of 'amiibo_list_cubit.dart';

sealed class AmiiboListState with Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class AmiiboListStateInitial extends AmiiboListState {
  const new();
}

final class AmiiboListStateSuccess extends AmiiboListState {
  const new({required this.amiiboList});

  final List<AmiiboModel> amiiboList;

  @override
  List<Object?> get props => [amiiboList];
}

final class AmiiboListStateError extends AmiiboListState {
  const new();
}
