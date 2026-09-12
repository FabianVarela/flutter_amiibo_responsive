import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'amiibo_series_model.g.dart';

@JsonSerializable(createToJson: false)
class AmiiboSeriesModel with Equatable {
  const new({required this.key, required this.name});

  factory fromJson(Map<String, dynamic> json) =>
      _$AmiiboSeriesModelFromJson(json);

  final String key;
  final String name;

  @override
  List<Object?> get props => [key, name];
}

@JsonSerializable(createToJson: false)
class GameSeriesModel with Equatable {
  const new({required this.key, required this.name});

  factory fromJson(Map<String, dynamic> json) =>
      _$GameSeriesModelFromJson(json);

  final String key;
  final String name;

  @override
  List<Object?> get props => [key, name];
}
