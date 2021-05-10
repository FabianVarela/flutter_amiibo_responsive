import 'dart:convert';

import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
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
      throw Exception('error getting data');
    }

    final amiiboList = jsonDecode(response.body)['amiibo'] as List<dynamic>;
    return amiiboList.map((item) => AmiiboModel.fromJson(item)).toList();
  }
}
