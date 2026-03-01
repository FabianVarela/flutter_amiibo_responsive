import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.dart';
import 'package:flutter_amiibo_responsive/view/home_page.dart';
import 'package:flutter_amiibo_responsive/view/unknown_page.dart';

final class HomePageRoute extends Page<dynamic> {
  HomePageRoute({
    required this.onChangeType,
    required this.onChangeGameSeries,
    required this.onChangeAmiiboSeries,
    required this.onGoToDetail,
    this.type,
    this.gameSeries,
    this.amiiboSeries,
  }) : super(
         key: ValueKey(
           'HomePageRoute_${type ?? 'none'}'
           '_${gameSeries ?? 'all'}_${amiiboSeries ?? 'all'}',
         ),
       );

  final String? type;
  final String? gameSeries;
  final String? amiiboSeries;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String?> onChangeGameSeries;
  final ValueSetter<String?> onChangeAmiiboSeries;
  final ValueSetter<String> onGoToDetail;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      settings: this,
      builder: (_) => HomePage(
        type: type,
        gameSeries: gameSeries,
        amiiboSeries: amiiboSeries,
        onChangeType: onChangeType,
        onChangeGameSeries: onChangeGameSeries,
        onChangeAmiiboSeries: onChangeAmiiboSeries,
        onGoToDetail: onGoToDetail,
      ),
    );
  }
}

final class DetailPageRoute extends Page<dynamic> {
  DetailPageRoute({required this.amiiboId, this.type})
    : super(key: ValueKey('DetailPageRoute_$amiiboId'));

  final String? type;
  final String amiiboId;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, animation, _) => FadeTransition(
        opacity: animation,
        child: DetailPage(type: type, amiiboId: amiiboId),
      ),
    );
  }
}

final class UnknownPageRoute extends Page<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, animation, _) => ScaleTransition(
        scale: animation,
        child: const UnknownPageUI(),
      ),
    );
  }
}
