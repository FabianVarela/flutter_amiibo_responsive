part of 'amiibo_list_cubit.dart';

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
