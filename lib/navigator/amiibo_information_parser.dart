import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_configuration.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';

class AmiiboInfoParser extends RouteInformationParser<AmiiboConfiguration> {
  @override
  Future<AmiiboConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    final segments = uri.pathSegments;

    if (segments.isEmpty) {
      return const AmiiboConfiguration.home();
    } else if (segments.length == 1) {
      if (segments[0] == AmiiboPath.home) {
        return const AmiiboConfiguration.home();
      }
    } else if (segments.length == 2) {
      if (segments[0] == AmiiboPath.home) {
        if (_existAmiiboType(segments[1])) {
          return AmiiboConfiguration.home(valueType: segments[1]);
        }
      }
    } else if (segments.length == 3) {
      if (segments[0] == AmiiboPath.home) {
        if (segments[1] == AmiiboPath.detail) {
          return AmiiboConfiguration.detail(valueId: segments[2]);
        }
      }
    } else if (segments.length == 4) {
      if (segments[0] == AmiiboPath.home) {
        if (_existAmiiboType(segments[1])) {
          if (segments[2] == AmiiboPath.detail) {
            return AmiiboConfiguration.detail(
              valueType: segments[1],
              valueId: segments[3],
            );
          }
        }
      }
    }

    return const AmiiboConfiguration.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AmiiboConfiguration configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/${AmiiboPath.notFound}');
    } else if (configuration.isHomePage) {
      return const RouteInformation(location: '/${AmiiboPath.home}');
    } else if (configuration.isHomeTypePage) {
      return RouteInformation(
        location: '/${AmiiboPath.home}/${configuration.type}',
      );
    } else if (configuration.isDetailNoTypePage) {
      final id = configuration.amiiboId;

      return RouteInformation(
        location: '/${AmiiboPath.home}/${AmiiboPath.detail}/$id',
      );
    } else if (configuration.isDetailPage) {
      final type = configuration.type;
      final id = configuration.amiiboId;

      return RouteInformation(
        location: '/${AmiiboPath.home}/$type/${AmiiboPath.detail}/$id',
      );
    }

    return null;
  }

  bool _existAmiiboType(String type) {
    final existsType = AmiiboType.values.where((el) => el.name == type);
    return existsType.isNotEmpty;
  }
}
