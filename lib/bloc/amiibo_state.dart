import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

enum AmiiboStatus { initial, success, failure }

class AmiiboState extends Equatable {
  const AmiiboState({
    this.status = AmiiboStatus.initial,
    this.amiiboList = const <AmiiboModel>[],
  });

  final AmiiboStatus status;
  final List<AmiiboModel> amiiboList;

  AmiiboState copyWith({
    AmiiboStatus? status,
    List<AmiiboModel>? amiiboList,
  }) {
    return AmiiboState(
      status: status ?? this.status,
      amiiboList: amiiboList ?? this.amiiboList,
    );
  }

  @override
  List<Object?> get props => [status, amiiboList];
}
