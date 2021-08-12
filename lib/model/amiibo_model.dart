import 'package:equatable/equatable.dart';
import 'package:flutter_amiibo_responsive/utils/utilities.dart';

class AmiiboModel extends Equatable {
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

  AmiiboModel.fromJson(Map<String, dynamic> json)
      : amiiboSeries = json['amiiboSeries'] as String,
        character = json['character'] as String,
        gameSeries = json['gameSeries'] as String,
        head = json['head'] as String,
        imageUrl = json['image'] as String,
        name = json['name'] as String,
        releaseDate = json['release'] != null
            ? ReleaseDate.fromJson(json['release'] as Map<String, dynamic>)
            : null,
        tail = json['tail'] as String,
        type = json['type'] as String;

  final String amiiboSeries;
  final String character;
  final String gameSeries;
  final String head;
  final String imageUrl;
  final String name;
  final ReleaseDate? releaseDate;
  final String tail;
  final String type;

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
        type
      ];
}

class ReleaseDate extends Equatable {
  const ReleaseDate({
    this.australia,
    this.europe,
    this.japan,
    this.northAm,
  });

  factory ReleaseDate.fromJson(Map<String, dynamic> json) {
    return ReleaseDate(
      australia: json['au'] != null
          ? Utilities.stringToDate(json['au'] as String)
          : null,
      europe: json['eu'] != null
          ? Utilities.stringToDate(json['eu'] as String)
          : null,
      japan: json['jp'] != null
          ? Utilities.stringToDate(json['jp'] as String)
          : null,
      northAm: json['na'] != null
          ? Utilities.stringToDate(json['na'] as String)
          : null,
    );
  }

  final DateTime? australia;
  final DateTime? europe;
  final DateTime? japan;
  final DateTime? northAm;

  @override
  List<Object?> get props => [australia, europe, japan, northAm];
}
