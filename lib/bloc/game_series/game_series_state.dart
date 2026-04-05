part of 'game_series_cubit.dart';

sealed class GameSeriesState with EquatableMixin {
  const GameSeriesState();

  @override
  List<Object?> get props => [];
}

final class GameSeriesStateInitial extends GameSeriesState {
  const GameSeriesStateInitial();
}

final class GameSeriesStateLoading extends GameSeriesState {
  const GameSeriesStateLoading();
}

final class GameSeriesStateSuccess extends GameSeriesState {
  const GameSeriesStateSuccess({required this.gameSeriesList});

  final List<GameSeriesModel> gameSeriesList;

  @override
  List<Object?> get props => [gameSeriesList];
}

final class GameSeriesStateError extends GameSeriesState {
  const GameSeriesStateError();
}
