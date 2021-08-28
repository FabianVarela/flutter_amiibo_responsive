import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/view/detail_page_ui.dart';
import 'package:flutter_amiibo_responsive/view/home_ui.dart';

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
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: DetailPageUI(amiibo: amiiboModel),
      ),
    );
  }
}
