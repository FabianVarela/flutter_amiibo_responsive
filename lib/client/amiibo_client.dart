import 'dart:convert';

import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:http/http.dart';

class AmiiboClient {
  AmiiboClient(this._client) : _baseUrl = 'www.amiiboapi.com';

  final Client _client;
  final String _baseUrl;

  Future<List<AmiiboModel>> getAmiiboList(String? param) async {
    final queryParams = param != null ? <String, dynamic>{'type': param} : null;

    final response = await _client.get(
      Uri.https(_baseUrl, '/api/amiibo/', queryParams),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final amiiboList = json['amiibo'] as List<dynamic>;

    return amiiboList.map((dynamic item) {
      final castItem = item as Map<String, dynamic>;
      return AmiiboModel.fromJson(castItem);
    }).toList();
  }
}
