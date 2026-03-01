import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'amiibo_model.g.dart';

@JsonSerializable(createToJson: false)
class AmiiboModel with EquatableMixin {
  const AmiiboModel({
    required this.amiiboSeries,
    required this.character,
    required this.head,
    required this.imageUrl,
    required this.name,
    required this.tail,
    required this.type,
    this.gameSeries,
    this.releaseDate,
    this.games3DS,
    this.gamesWiiU,
    this.gamesSwitch,
  });

  factory AmiiboModel.fromJson(Map<String, dynamic> json) =>
      _$AmiiboModelFromJson(json);

  final String amiiboSeries;
  final String character;
  final String? gameSeries;
  final String head;

  @JsonKey(name: 'image')
  final String imageUrl;

  final String name;

  @JsonKey(name: 'release')
  final ReleaseDateModel? releaseDate;

  final String tail;
  final String type;
  final List<GameInfoModel>? games3DS;
  final List<GameInfoModel>? gamesWiiU;
  final List<GameInfoModel>? gamesSwitch;

  @override
  List<Object?> get props => [
    amiiboSeries,
    character,
    gameSeries,
    head,
    imageUrl,
    name,
    releaseDate,
    tail,
    type,
    games3DS,
    gamesWiiU,
    gamesSwitch,
  ];
}

@JsonSerializable(createToJson: false)
class ReleaseDateModel with EquatableMixin {
  const ReleaseDateModel({
    this.australia,
    this.europe,
    this.japan,
    this.northAm,
  });

  factory ReleaseDateModel.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDateModelFromJson(json);

  @JsonKey(name: 'au', fromJson: _getDateTime)
  final DateTime? australia;

  @JsonKey(name: 'eu', fromJson: _getDateTime)
  final DateTime? europe;

  @JsonKey(name: 'jp', fromJson: _getDateTime)
  final DateTime? japan;

  @JsonKey(name: 'na', fromJson: _getDateTime)
  final DateTime? northAm;

  static DateTime? _getDateTime(String? value) {
    if (value == null) return null;
    return DateFormat('yyyy-MM-dd').parse(value);
  }

  @override
  List<Object?> get props => [australia, europe, japan, northAm];
}
