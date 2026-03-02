import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_series_model.dart';

class AmiiboRepository {
  AmiiboRepository(this._amiiboClient);

  final AmiiboClient _amiiboClient;

  Future<List<AmiiboModel>> getAmiiboList({
    String? type,
    String? gameSeries,
    String? amiiboSeries,
  }) => _amiiboClient.getAmiiboList(
    type: type,
    gameSeries: gameSeries,
    amiiboSeries: amiiboSeries,
  );

  Future<AmiiboModel> getAmiiboItem(String? type, String id) =>
      _amiiboClient.getAmiiboItem(type, id);

  Future<List<GameSeriesModel>> getGameSeriesList({
    String? key,
    String? name,
  }) => _amiiboClient.getGameSeriesList(key: key, name: name);

  Future<List<AmiiboSeriesModel>> getAmiiboSeriesList({
    String? key,
    String? name,
  }) => _amiiboClient.getAmiiboSeriesList(key: key, name: name);
}
