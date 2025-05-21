// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amiibo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmiiboModel _$AmiiboModelFromJson(Map<String, dynamic> json) => AmiiboModel(
  amiiboSeries: json['amiiboSeries'] as String,
  character: json['character'] as String,
  head: json['head'] as String,
  imageUrl: json['image'] as String,
  name: json['name'] as String,
  tail: json['tail'] as String,
  type: json['type'] as String,
  gameSeries: json['gameSeries'] as String?,
  releaseDate: json['release'] == null
      ? null
      : ReleaseDateModel.fromJson(json['release'] as Map<String, dynamic>),
);

ReleaseDateModel _$ReleaseDateModelFromJson(Map<String, dynamic> json) =>
    ReleaseDateModel(
      australia: ReleaseDateModel._getDateTime(json['au'] as String?),
      europe: ReleaseDateModel._getDateTime(json['eu'] as String?),
      japan: ReleaseDateModel._getDateTime(json['jp'] as String?),
      northAm: ReleaseDateModel._getDateTime(json['na'] as String?),
    );
