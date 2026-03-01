import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amiibo_series_state.dart';

final class AmiiboSeriesCubit extends Cubit<AmiiboSeriesState> {
  AmiiboSeriesCubit(this._repository) : super(const AmiiboSeriesStateInitial());

  final AmiiboRepository _repository;

  Future<void> fetchAmiiboSeries() async {
    emit(const AmiiboSeriesStateLoading());

    try {
      final resultList = await _repository.getAmiiboSeriesList();
      if (isClosed) return;

      final uniqueNames = <String>{};
      final uniqueList =
          resultList.where((series) => uniqueNames.add(series.name)).toList()
            ..sort((a, b) => a.name.compareTo(b.name));

      emit(AmiiboSeriesStateSuccess(amiiboSeriesList: uniqueList));
    } on Exception {
      if (isClosed) return;
      emit(const AmiiboSeriesStateError());
    }
  }
}
