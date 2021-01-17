import 'package:flutter_amiibo_responsive/utils/utilities.dart';

class AmiiboModel {
  AmiiboModel({
    this.amiiboSeries,
    this.character,
    this.gameSeries,
    this.head,
    this.imageUrl,
    this.name,
    this.releaseDate,
    this.tail,
    this.type,
  });

  final String amiiboSeries;
  final String character;
  final String gameSeries;
  final String head;
  final String imageUrl;
  final String name;
  final ReleaseDate releaseDate;
  final String tail;
  final String type;

  AmiiboModel.fromJson(Map<String, dynamic> json)
      : amiiboSeries = json['amiiboSeries'],
        character = json['character'],
        gameSeries = json['gameSeries'],
        head = json['head'],
        imageUrl = json['image'],
        name = json['name'],
        releaseDate = json['release'] != null
            ? ReleaseDate.fromJson(json['release'])
            : null,
        tail = json['tail'],
        type = json['type'];
}

class ReleaseDate {
  ReleaseDate({this.australia, this.europe, this.japan, this.northAm});

  final DateTime australia;
  final DateTime europe;
  final DateTime japan;
  final DateTime northAm;

  factory ReleaseDate.fromJson(Map<String, dynamic> json) {
    return ReleaseDate(
      australia: json['au'] != null ? Utilities.stringToDate(json['au']) : null,
      europe: json['eu'] != null ? Utilities.stringToDate(json['eu']) : null,
      japan: json['jp'] != null ? Utilities.stringToDate(json['jp']) : null,
      northAm: json['na'] != null ? Utilities.stringToDate(json['na']) : null,
    );
  }
}
