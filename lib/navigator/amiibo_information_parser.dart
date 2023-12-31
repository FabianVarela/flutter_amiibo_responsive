import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/amiibo_configuration.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';

class AmiiboInfoParser extends RouteInformationParser<AmiiboConfiguration> {
  @override
  Future<AmiiboConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final segments = routeInformation.uri.pathSegments;

    if (segments.isEmpty) {
      return const AmiiboConfiguration.home();
    } else if (segments.length == 1) {
      if (segments[0] == AmiiboPath.home) {
        return const AmiiboConfiguration.home();
      }
    } else if (segments.length == 2) {
      if (segments[0] == AmiiboPath.home) {
        if (_existAmiiboType(segments[1])) {
          return AmiiboConfiguration.home(type: segments[1]);
        }
      }
    } else if (segments.length == 3) {
      if (segments[0] == AmiiboPath.home) {
        if (segments[1] == AmiiboPath.detail) {
          return AmiiboConfiguration.detail(amiiboId: segments[2]);
        }
      }
    } else if (segments.length == 4) {
      if (segments[0] == AmiiboPath.home) {
        if (_existAmiiboType(segments[1])) {
          if (segments[2] == AmiiboPath.detail) {
            return AmiiboConfiguration.detail(
              type: segments[1],
              amiiboId: segments[3],
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
      return RouteInformation(uri: Uri.parse('/${AmiiboPath.notFound}'));
    } else if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/${AmiiboPath.home}'));
    } else if (configuration.isHomeTypePage) {
      return RouteInformation(
        uri: Uri.parse('/${AmiiboPath.home}/${configuration.type}'),
      );
    } else if (configuration.isDetailNoTypePage) {
      final id = configuration.amiiboId;

      return RouteInformation(
        uri: Uri.parse('/${AmiiboPath.home}/${AmiiboPath.detail}/$id'),
      );
    } else if (configuration.isDetailPage) {
      final type = configuration.type;
      final id = configuration.amiiboId;

      return RouteInformation(
        uri: Uri.parse('/${AmiiboPath.home}/$type/${AmiiboPath.detail}/$id'),
      );
    }

    return null;
  }

  bool _existAmiiboType(String type) {
    final existsType = AmiiboType.values.where((el) => el.name == type);
    return existsType.isNotEmpty;
  }
}
