import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.dart';
import 'package:flutter_amiibo_responsive/view/home_page.dart';
import 'package:flutter_amiibo_responsive/view/unknown_page.dart';

class HomePageRoute extends Page<dynamic> {
  HomePageRoute({
    required this.onChangeType,
    required this.onGoToDetail,
    this.type,
  }) : super(key: ValueKey('HomePageRoute_${type ?? 'none'}'));

  final String? type;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String> onGoToDetail;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      settings: this,
      builder: (_) => HomePage(
        type: type,
        onChange: onChangeType,
        onGoToDetail: onGoToDetail,
      ),
    );
  }
}

class DetailPageRoute extends Page<dynamic> {
  DetailPageRoute({required this.amiiboId, this.type})
      : super(key: ValueKey('DetailPageRoute_$amiiboId'));

  final String? type;
  final String amiiboId;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: DetailPage(type: type, amiiboId: amiiboId),
      ),
    );
  }
}

class UnknownPageRoute extends Page<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, animation, __) => ScaleTransition(
        scale: animation,
        child: const UnknownPageUI(),
      ),
    );
  }
}
