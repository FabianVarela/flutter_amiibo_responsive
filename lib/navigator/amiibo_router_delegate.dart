import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_configuration.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_pages.dart';

class AmiiboRouterDelegate extends RouterDelegate<AmiiboConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AmiiboConfiguration> {
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

  bool _is404 = false;

  bool get is404 => _is404;

  set is404(bool value) {
    _is404 = value;

    if (value) {
      _amiiboType = null;
      _amiiboId = null;
    }

    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: [_heroController],
      key: navigatorKey,
      pages: <Page<dynamic>>[
        if (is404)
          UnknownPageRoute()
        else ...[
          HomePageRoute(
            type: amiiboType,
            onChangeType: (type) => amiiboType = type,
            onGoToDetail: (id) => amiiboId = id,
          ),
          if (amiiboId != null)
            DetailPageRoute(type: amiiboType, amiiboId: amiiboId!),
        ]
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) return false;

        if (amiiboId != null) amiiboId = null;
        return true;
      },
    );
  }

  @override
  AmiiboConfiguration? get currentConfiguration {
    if (amiiboType == null && amiiboId == null && !is404) {
      return const AmiiboConfiguration.home();
    } else if (amiiboType != null && amiiboId == null && !is404) {
      return AmiiboConfiguration.home(type: amiiboType);
    } else if (amiiboId != null && !is404) {
      return AmiiboConfiguration.detail(type: amiiboType, amiiboId: amiiboId);
    } else if (is404) {
      return const AmiiboConfiguration.unknown();
    }

    return null;
  }

  @override
  Future<void> setNewRoutePath(AmiiboConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      _changeValues(isNotFound: true);
    } else if (configuration.isHomePage) {
      _changeValues();
    } else if (configuration.isHomeTypePage) {
      _changeValues(type: configuration.type);
    } else if (configuration.isDetailNoTypePage) {
      _changeValues(id: configuration.amiiboId);
    } else if (configuration.isDetailPage) {
      _changeValues(type: configuration.type, id: configuration.amiiboId);
    }
  }

  void _changeValues({String? type, String? id, bool isNotFound = false}) {
    amiiboType = type;
    amiiboId = id;
    is404 = isNotFound;
  }
}
