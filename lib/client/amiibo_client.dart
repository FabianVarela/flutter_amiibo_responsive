import 'dart:convert';

import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:http/http.dart';

class AmiiboClient {
  AmiiboClient(this._client) : _baseUrl = 'www.amiiboapi.com';

  final Client _client;
  final String _baseUrl;

  static const String _apiPath = '/api/amiibo/';

  Future<List<AmiiboModel>> getAmiiboList(String? type) async {
    final queryParams = type != null ? <String, dynamic>{'type': type} : null;
    final response = await _client.get(
      Uri.https(_baseUrl, _apiPath, queryParams),
    );

    if (response.statusCode != 200) throw Exception();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final amiiboList = json['amiibo'] as List<dynamic>;

    return amiiboList.map((dynamic item) {
      final castItem = item as Map<String, dynamic>;
      return AmiiboModel.fromJson(castItem);
    }).toList();
  }

  Future<AmiiboModel> getAmiiboItem(String? type, String id) async {
    final queryParams = type != null
        ? <String, dynamic>{'type': type, 'id': id}
        : <String, dynamic>{'id': id};

    final response = await _client.get(
      Uri.https(_baseUrl, _apiPath, queryParams),
    );

    if (response.statusCode != 200) throw Exception();

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final amiiboItem = json['amiibo'] as Map<String, dynamic>;

    return AmiiboModel.fromJson(amiiboItem);
  }
}
