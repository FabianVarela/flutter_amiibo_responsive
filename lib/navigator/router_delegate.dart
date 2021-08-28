import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/page.dart';

class AmiiboRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  AmiiboRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;
  final _heroController = HeroController();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  String? _amiiboType;

  String? get amiiboType => _amiiboType;

  set amiiboType(String? value) {
    _amiiboType = value;
    notifyListeners();
  }

  String? _amiiboId;

  String? get amiiboId => _amiiboId;

  set amiiboId(String? value) {
    _amiiboId = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: [_heroController],
      key: navigatorKey,
      pages: <Page<dynamic>>[
        HomePage(
          type: amiiboType,
          onChangeType: (type) => amiiboType = type,
          onGoToDetail: (id) => amiiboId = id,
        ),
        if (amiiboId != null) DetailPage(amiiboId: amiiboId!),
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) return false;

        if (amiiboId != null) amiiboId = null;
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {}
}
