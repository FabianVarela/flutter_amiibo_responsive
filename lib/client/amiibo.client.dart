import 'dart:convert';

import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:http/http.dart';

class AmiiboClient {
  final String baseUrl = 'https://www.amiiboapi.com';
  final Client _client;

  AmiiboClient(this._client);

  Future<List<AmiiboModel>> getAmiiboList() async {
    final amiiboUrl = '$baseUrl/api/amiibo/';
    final amiiboResponse = await _client.get(amiiboUrl);

    if (amiiboResponse.statusCode != 200) {
      throw Exception('error getting data');
    }

    final amiiboJsonList = jsonDecode(amiiboResponse.body)['amiibo'] as List<dynamic>;

    return amiiboJsonList
        .map((amiiboJson) => AmiiboModel.fromJson(amiiboJson))
        .toList();
  }
}
