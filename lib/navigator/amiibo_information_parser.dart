import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/navigator/config/amiibo_configuration.dart';
import 'package:flutter_amiibo_responsive/utils/enum.dart';

enum AmiiboPath {
  home('amiibos'),
  detail('amiibo'),
  notFound('404');

  const AmiiboPath(this.name);

  final String name;
}

extension _StringPathX on String {
  Uri get toUri => Uri.parse(this);
}

final class AmiiboInfoParser
    extends RouteInformationParser<AmiiboConfiguration> {
  @override
  Future<AmiiboConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final newPaths =
        routeInformation.uri.pathSegments.map((pathSegment) {
          final path = AmiiboPath.values.where(
            (val) => val.name == pathSegment,
          );
          return path.isEmpty ? pathSegment : pathSegment.toLowerCase();
        }).toList();

    if (newPaths.isEmpty) return const AmiiboConfigurationHome();

    if (newPaths.length == 1) {
      if (newPaths.first == AmiiboPath.home.name) {
        return const AmiiboConfigurationHome();
      }
    } else if (newPaths.length == 2) {
      if (newPaths.first == AmiiboPath.home.name && _hasType(newPaths.last)) {
        return AmiiboConfigurationHome(type: newPaths.last);
      }
    } else if (newPaths.length == 3) {
      if (newPaths.first == AmiiboPath.home.name) {
        if (newPaths[1] == AmiiboPath.detail.name) {
          return AmiiboConfigurationDetail(amiiboId: newPaths.last);
        }
      }
    } else if (newPaths.length == 4) {
      if (newPaths.first == AmiiboPath.home.name && _hasType(newPaths[1])) {
        if (newPaths[2] == AmiiboPath.detail.name) {
          return AmiiboConfigurationDetail(
            amiiboId: newPaths.last,
            type: newPaths[1],
          );
        }
      }
    }

    return const AmiiboConfigurationUnknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AmiiboConfiguration configuration) {
    final home = AmiiboPath.home.name;
    final detail = AmiiboPath.detail.name;
    final noFound = AmiiboPath.notFound.name;

    return switch (configuration) {
      AmiiboConfigurationUnknown() => RouteInformation(uri: '/$noFound'.toUri),
      AmiiboConfigurationHome(:final type) =>
        type != null
            ? RouteInformation(uri: '/$home/$type'.toUri)
            : RouteInformation(uri: '/$home'.toUri),
      AmiiboConfigurationDetail(:final amiiboId, :final type) =>
        type != null
            ? RouteInformation(uri: '/$home/$type/$detail/$amiiboId'.toUri)
            : RouteInformation(uri: '/$home/$detail/$amiiboId'.toUri),
    };
  }

  bool _hasType(String type) {
    return AmiiboType.values.where((el) => el.name == type).isNotEmpty;
  }
}
