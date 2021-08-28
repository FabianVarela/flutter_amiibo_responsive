import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

enum AmiiboItemStatus { initial, success, failure }

class AmiiboItemState extends Equatable {
  const AmiiboItemState({
    this.status = AmiiboItemStatus.initial,
    this.amiiboItem,
  });

  final AmiiboItemStatus status;
  final AmiiboModel? amiiboItem;

  AmiiboItemState copyWith({
    AmiiboItemStatus? status,
    AmiiboModel? amiiboItem,
  }) {
    return AmiiboItemState(
      status: status ?? this.status,
      amiiboItem: amiiboItem ?? this.amiiboItem,
    );
  }

  @override
  List<Object?> get props => [status, amiiboItem];
}
