import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_pages.dart';
import 'package:flutter_amiibo_responsive/navigator/config/amiibo_configuration.dart';

final class AmiiboRouterDelegate extends RouterDelegate<AmiiboConfiguration>
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
    var pages = <Page<dynamic>>[
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
      ],
    ];

    return Navigator(
      observers: [_heroController],
      key: navigatorKey,
      pages: pages,
      onDidRemovePage: (page) {
        if (amiiboId == null) {
          pages.remove(page);
          pages = pages.toList();
        } else {
          if (amiiboId != null) amiiboId = null;
        }
      },
    );
  }

  @override
  AmiiboConfiguration? get currentConfiguration {
    if (amiiboType == null && amiiboId == null && !is404) {
      return const AmiiboConfigurationHome();
    } else if (amiiboType != null && amiiboId == null && !is404) {
      return AmiiboConfigurationHome(type: amiiboType);
    } else if (amiiboId != null && !is404) {
      return AmiiboConfigurationDetail(amiiboId: amiiboId!, type: amiiboType);
    } else if (is404) {
      return const AmiiboConfigurationUnknown();
    }

    return null;
  }

  @override
  Future<void> setNewRoutePath(AmiiboConfiguration configuration) async {
    return switch (configuration) {
      AmiiboConfigurationUnknown() => _setValues(isNotFound: true),
      AmiiboConfigurationHome(:final type) => _setValues(type: type),
      AmiiboConfigurationDetail(:final amiiboId, :final type) =>
        _setValues(type: type, id: amiiboId),
    };
  }

  void _setValues({String? type, String? id, bool isNotFound = false}) {
    amiiboType = type;
    amiiboId = id;
    is404 = isNotFound;
  }

  void parseRoute(Uri uri) {
    final segments = uri.pathSegments;
    return switch (segments.length) {
      0 || 1 => _setValues(),
      2 => _setValues(type: segments[1]),
      3 when segments[1] == 'amiibo' => _setValues(id: segments[2]),
      4 => _setValues(type: segments[1], id: segments[3]),
      _ => _setValues(isNotFound: true),
    };
  }
}
