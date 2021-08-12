import 'package:flutter_amiibo_responsive/bloc/amiibo_state.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmiiboCubit extends Cubit<AmiiboState> {
  AmiiboCubit(this._repository) : super(const AmiiboState());

  final AmiiboRepository _repository;

  Future<void> fetchAmiiboData(String? param) async {
    emit(state.copyWith(status: AmiiboStatus.initial));

    try {
      final resultList = await _repository.getAmiiboList(param);
      emit(state.copyWith(
        status: AmiiboStatus.success,
        amiiboList: resultList,
      ));
    } on Exception {
      emit(state.copyWith(status: AmiiboStatus.failure));
    }
  }
}
