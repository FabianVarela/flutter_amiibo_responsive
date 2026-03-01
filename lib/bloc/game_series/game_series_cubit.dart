import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_series_state.dart';

final class GameSeriesCubit extends Cubit<GameSeriesState> {
  GameSeriesCubit(this._repository) : super(const GameSeriesStateInitial());

  final AmiiboRepository _repository;

  Future<void> fetchGameSeries() async {
    emit(const GameSeriesStateLoading());

    try {
      final resultList = await _repository.getGameSeriesList();
      if (isClosed) return;

      final uniqueNames = <String>{};
      final uniqueList =
          resultList.where((series) => uniqueNames.add(series.name)).toList()
            ..sort((a, b) => a.name.compareTo(b.name));

      emit(GameSeriesStateSuccess(gameSeriesList: uniqueList));
    } on Exception {
      if (isClosed) return;
      emit(const GameSeriesStateError());
    }
  }
}
