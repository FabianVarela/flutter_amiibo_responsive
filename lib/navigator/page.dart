import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo.model.dart';
import 'package:flutter_amiibo_responsive/view/detail_page.ui.dart';
import 'package:flutter_amiibo_responsive/view/home.ui.dart';

class HomePage extends Page<dynamic> {
  const HomePage({required this.onGoToDetail})
      : super(key: const ValueKey('HomePage'));

  final ValueSetter<AmiiboModel> onGoToDetail;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      settings: this,
      builder: (_) => HomePageUI(onGoToDetail: onGoToDetail),
    );
  }
}

class DetailPage extends Page<dynamic> {
  const DetailPage({required this.amiiboModel})
      : super(key: const ValueKey('DetailPage'));

  final AmiiboModel amiiboModel;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      settings: this,
      builder: (_) => DetailPageUI(amiibo: amiiboModel),
    );
  }
}
