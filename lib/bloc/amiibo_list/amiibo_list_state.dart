import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

enum AmiiboListStatus { initial, success, failure }

class AmiiboListState extends Equatable {
  const AmiiboListState({
    this.status = AmiiboListStatus.initial,
    this.amiiboList = const <AmiiboModel>[],
  });

  final AmiiboListStatus status;
  final List<AmiiboModel> amiiboList;

  AmiiboListState copyWith({
    AmiiboListStatus? status,
    List<AmiiboModel>? amiiboList,
  }) {
    return AmiiboListState(
      status: status ?? this.status,
      amiiboList: amiiboList ?? this.amiiboList,
    );
  }

  @override
  List<Object?> get props => [status, amiiboList];
}
