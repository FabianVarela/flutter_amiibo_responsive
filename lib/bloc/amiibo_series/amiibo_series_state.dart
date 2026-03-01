part of 'amiibo_series_cubit.dart';

sealed class AmiiboSeriesState extends Equatable {
  const AmiiboSeriesState();

  @override
  List<Object?> get props => [];
}

final class AmiiboSeriesStateInitial extends AmiiboSeriesState {
  const AmiiboSeriesStateInitial();
}

final class AmiiboSeriesStateLoading extends AmiiboSeriesState {
  const AmiiboSeriesStateLoading();
}

final class AmiiboSeriesStateSuccess extends AmiiboSeriesState {
  const AmiiboSeriesStateSuccess({required this.amiiboSeriesList});

  final List<AmiiboSeriesModel> amiiboSeriesList;

  @override
  List<Object?> get props => [amiiboSeriesList];
}

final class AmiiboSeriesStateError extends AmiiboSeriesState {
  const AmiiboSeriesStateError();
}
