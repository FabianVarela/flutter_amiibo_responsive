// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amiibo_series_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmiiboSeriesModel _$AmiiboSeriesModelFromJson(Map<String, dynamic> json) =>
    AmiiboSeriesModel(key: json['key'] as String, name: json['name'] as String);

GameSeriesModel _$GameSeriesModelFromJson(Map<String, dynamic> json) =>
    GameSeriesModel(key: json['key'] as String, name: json['name'] as String);

GameInfoModel _$GameInfoModelFromJson(Map<String, dynamic> json) =>
    GameInfoModel(
      gameID: json['gameID'] as String,
      gameName: json['gameName'] as String,
      amiiboUsage: (json['amiiboUsage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
