import 'dart:convert';

import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';

const String jsonListResponse =
    '{ "amiibo": [ { "amiiboSeries": "Legend Of Zelda", '
    '"character": "Zelda", "gameSeries": "The Legend of Zelda", '
    '"head": "01010000", "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_01010000-03520902.png", '
    '"name": "Toon Zelda - The Wind Waker", "release": { "au": "2016-12-03", '
    '"eu": "2016-12-02", "jp": "2016-12-01", "na": "2016-12-02" }, '
    '"tail": "03520902", "type": "Figure" } ] }';

const String jsonDetailResponse =
    '{ "amiibo": { "amiiboSeries": "Legend Of Zelda", '
    '"character": "Zelda", "gameSeries": "The Legend of Zelda", '
    '"head": "01010000", "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_01010000-03520902.png", '
    '"name": "Toon Zelda - The Wind Waker", "release": { "au": "2016-12-03", '
    '"eu": "2016-12-02", "jp": "2016-12-01", "na": "2016-12-02" }, '
    '"tail": "03520902", "type": "Figure"} }';

const amiiboType = 'figure';

const amiiboId = '01010000000e0002';

AmiiboModel get amiiboModel {
  final amiiboMap = jsonDecode(jsonDetailResponse) as Map<String, dynamic>;
  return AmiiboModel.fromJson(amiiboMap['amiibo'] as Map<String, dynamic>);
}
