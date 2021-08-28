import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/view/detail_page_ui.dart';
import 'package:flutter_amiibo_responsive/view/home_ui.dart';

class HomePage extends Page<dynamic> {
  HomePage({
    this.type,
    required this.onChangeType,
    required this.onGoToDetail,
  }) : super(key: ValueKey('HomePage_${type ?? 'none'}'));

  final String? type;
  final ValueSetter<String?> onChangeType;
  final ValueSetter<String> onGoToDetail;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      settings: this,
      builder: (_) => HomePageUI(
        type: type,
        onChangeType: onChangeType,
        onGoToDetail: onGoToDetail,
      ),
    );
  }
}

class DetailPage extends Page<dynamic> {
  const DetailPage({required this.amiiboId})
      : super(key: const ValueKey('DetailPage'));

  final String amiiboId;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: DetailPageUI(amiiboId: amiiboId),
      ),
    );
  }
}
