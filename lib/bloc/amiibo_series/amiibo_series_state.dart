part of 'amiibo_series_cubit.dart';

sealed class AmiiboSeriesState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class AmiiboSeriesStateInitial extends AmiiboSeriesState {
  const new();
}

final class AmiiboSeriesStateLoading extends AmiiboSeriesState {
  const new();
}

final class AmiiboSeriesStateSuccess extends AmiiboSeriesState {
  const new({required this.amiiboSeriesList});

  final List<AmiiboSeriesModel> amiiboSeriesList;

  @override
  List<Object?> get props => [amiiboSeriesList];
}

final class AmiiboSeriesStateError extends AmiiboSeriesState {
  const new();
}
