import 'dart:convert';

import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';
import 'package:http/http.dart';

class AmiiboClient {
  AmiiboClient(this._client) : _baseUrl = 'www.amiiboapi.org';

  final Client _client;
  final String _baseUrl;

  static const String _apiPath = '/api/amiibo/';
  static const String _gameSeriesPath = '/api/gameseries/';
  static const String _amiiboSeriesPath = '/api/amiiboseries/';

  Future<List<AmiiboModel>> getAmiiboList({
    String? type,
    String? gameSeries,
    String? amiiboSeries,
  }) async {
    final queryParams = <String, dynamic>{
      'type': ?type,
      'gameseries': ?gameSeries,
      'amiiboSeries': ?amiiboSeries,
    };

    final response = await _client.get(
      Uri.https(_baseUrl, _apiPath, queryParams),
    );

    if (response.statusCode != 200) throw Exception();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final amiiboList = json['amiibo'] as List<dynamic>;

    return [
      for (final item in amiiboList)
        AmiiboModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  Future<AmiiboModel> getAmiiboItem(String? type, String id) async {
    final queryParams = <String, dynamic>{'id': id, 'type': ?type};
    final response = await _client.get(
      Uri.https(_baseUrl, _apiPath, queryParams),
    );

    if (response.statusCode != 200) throw Exception();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final amiiboItem = json['amiibo'] as Map<String, dynamic>?;

    if (amiiboItem == null) throw Exception();
    return AmiiboModel.fromJson(amiiboItem);
  }

  Future<List<GameSeriesModel>> getGameSeriesList({
    String? key,
    String? name,
  }) async {
    final queryParams = <String, dynamic>{'key': ?key, 'name': ?name};
    final response = await _client.get(
      Uri.https(_baseUrl, _gameSeriesPath, queryParams),
    );

    if (response.statusCode != 200) throw Exception();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final gameSeriesList = json['amiibo'] as List<dynamic>;

    return [
      for (final item in gameSeriesList)
        GameSeriesModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  Future<List<AmiiboSeriesModel>> getAmiiboSeriesList({
    String? key,
    String? name,
  }) async {
    final queryParams = <String, dynamic>{'key': ?key, 'name': ?name};
    final response = await _client.get(
      Uri.https(_baseUrl, _amiiboSeriesPath, queryParams),
    );

    if (response.statusCode != 200) throw Exception();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final amiiboSeriesList = json['amiibo'] as List<dynamic>;

    return [
      for (final item in amiiboSeriesList)
        AmiiboSeriesModel.fromJson(item as Map<String, dynamic>),
    ];
  }
}
