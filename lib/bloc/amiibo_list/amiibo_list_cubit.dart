import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_state.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmiiboListCubit extends Cubit<AmiiboListState> {
  AmiiboListCubit(this._repository) : super(const AmiiboListStateInitial());

  final AmiiboRepository _repository;

  Future<void> fetchAmiiboData(String? param) async {
    emit(const AmiiboListStateInitial());

    try {
      final resultList = await _repository.getAmiiboList(param);
      emit(AmiiboListStateSuccess(resultList));
    } on Exception {
      emit(const AmiiboListStateError());
    }
  }
}
