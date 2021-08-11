import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/navigator/page.dart';

class AmiiboRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  AmiiboRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;
  final _heroController = HeroController();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  AmiiboModel? _amiiboModel;

  AmiiboModel? get amiiboModel => _amiiboModel;

  set amiiboModel(AmiiboModel? value) {
    _amiiboModel = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: [_heroController],
      key: navigatorKey,
      pages: <Page<dynamic>>[
        HomePage(
          onGoToDetail: (model) => amiiboModel = model,
        ),
        if (amiiboModel != null)
          DetailPage(
            amiiboModel: amiiboModel!,
          ),
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) return false;

        amiiboModel = null;
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {}
}
