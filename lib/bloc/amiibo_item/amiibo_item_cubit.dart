import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amiibo_item_state.dart';

class AmiiboItemCubit extends Cubit<AmiiboItemState> {
  AmiiboItemCubit(this._repository) : super(const AmiiboItemStateInitial());

  final AmiiboRepository _repository;

  Future<void> fetchAmiiboItem(String? type, String id) async {
    emit(const AmiiboItemStateInitial());

    try {
      final result = await _repository.getAmiiboItem(type, id);
      emit(AmiiboItemStateSuccess(amiiboItem: result));
    } on Exception {
      emit(const AmiiboItemStateError());
    }
  }
}
