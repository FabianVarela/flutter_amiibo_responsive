part of 'game_series_cubit.dart';

sealed class GameSeriesState with Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class GameSeriesStateInitial extends GameSeriesState {
  const new();
}

final class GameSeriesStateLoading extends GameSeriesState {
  const new();
}

final class GameSeriesStateSuccess extends GameSeriesState {
  const new({required this.gameSeriesList});

  final List<GameSeriesModel> gameSeriesList;

  @override
  List<Object?> get props => [gameSeriesList];
}

final class GameSeriesStateError extends GameSeriesState {
  const new();
}
