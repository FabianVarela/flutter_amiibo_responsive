import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

class AmiiboRepository {
  AmiiboRepository(this._amiiboClient);

  final AmiiboClient _amiiboClient;

  Future<List<AmiiboModel>> getAmiiboList(String? param) =>
      _amiiboClient.getAmiiboList(param);

  Future<AmiiboModel> getAmiiboItem(String id) =>
      _amiiboClient.getAmiiboItem(id);
}
