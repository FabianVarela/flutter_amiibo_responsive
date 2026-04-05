import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'amiibo_series_model.g.dart';

@JsonSerializable(createToJson: false)
class AmiiboSeriesModel with EquatableMixin {
  const AmiiboSeriesModel({required this.key, required this.name});

  factory AmiiboSeriesModel.fromJson(Map<String, dynamic> json) =>
      _$AmiiboSeriesModelFromJson(json);

  final String key;
  final String name;

  @override
  List<Object?> get props => [key, name];
}

@JsonSerializable(createToJson: false)
class GameSeriesModel with EquatableMixin {
  const GameSeriesModel({required this.key, required this.name});

  factory GameSeriesModel.fromJson(Map<String, dynamic> json) =>
      _$GameSeriesModelFromJson(json);

  final String key;
  final String name;

  @override
  List<Object?> get props => [key, name];
}
