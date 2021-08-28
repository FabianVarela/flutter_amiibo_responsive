import 'package:flutter_amiibo_responsive/bloc/amiibo_list/amiibo_list_state.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmiiboListCubit extends Cubit<AmiiboListState> {
  AmiiboListCubit(this._repository) : super(const AmiiboListState());

  final AmiiboRepository _repository;

  Future<void> fetchAmiiboData(String? param) async {
    emit(state.copyWith(status: AmiiboListStatus.initial));

    try {
      final resultList = await _repository.getAmiiboList(param);
      emit(state.copyWith(
        status: AmiiboListStatus.success,
        amiiboList: resultList,
      ));
    } on Exception {
      emit(state.copyWith(status: AmiiboListStatus.failure));
    }
  }
}
