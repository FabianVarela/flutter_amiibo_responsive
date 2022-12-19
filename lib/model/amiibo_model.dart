import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'amiibo_model.g.dart';

@JsonSerializable(createToJson: false)
class AmiiboModel {
  const AmiiboModel({
    required this.amiiboSeries,
    required this.character,
    required this.gameSeries,
    required this.head,
    required this.imageUrl,
    required this.name,
    this.releaseDate,
    required this.tail,
    required this.type,
  });

  factory AmiiboModel.fromJson(Map<String, dynamic> json) =>
      _$AmiiboModelFromJson(json);

  final String amiiboSeries;
  final String character;
  final String gameSeries;
  final String head;

  @JsonKey(name: 'image')
  final String imageUrl;

  final String name;

  @JsonKey(name: 'release')
  final ReleaseDateModel? releaseDate;

  final String tail;
  final String type;
}

@JsonSerializable(createToJson: false)
class ReleaseDateModel {
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
}
