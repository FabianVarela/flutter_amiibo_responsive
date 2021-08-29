import 'package:flutter_amiibo_responsive/bloc/amiibo_item/amiibo_item_state.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmiiboItemCubit extends Cubit<AmiiboItemState> {
  AmiiboItemCubit(this._repository) : super(const AmiiboItemState());

  final AmiiboRepository _repository;

  Future<void> fetchAmiiboItem(String? type, String id) async {
    emit(state.copyWith(status: AmiiboItemStatus.initial));

    try {
      final result = await _repository.getAmiiboItem(type, id);
      emit(state.copyWith(
        status: AmiiboItemStatus.success,
        amiiboItem: result,
      ));
    } on Exception {
      emit(state.copyWith(status: AmiiboItemStatus.failure));
    }
  }
}
